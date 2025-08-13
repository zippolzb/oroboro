extends Control

const IMAGE_SIZE = Vector2(100,100)

var level_loop = []
var loop_dict = []

func _ready():
	await get_tree().process_frame
	level_loop = get_parent().level_loop_dict
	loop_dict = level_loop.duplicate()
	var count = 0
	for item in level_loop:
		var size = 105
		var x_pos = size*count
		count = count + 1
		setup_margin_container(item.node, x_pos, 0, IMAGE_SIZE)

func setup_margin_container(node: MarginContainer, x: int, y: int, size: Vector2):
	node.size = size
	node.position = Vector2(x, y)

func move_loop():
	var to_change = loop_dict[0]
	var new_texture = load(to_change.used_image)
	to_change.node.get_node('TextureRect').texture = new_texture
	loop_dict.pop_front()
	if len(loop_dict) == 0:
			loop_dict = level_loop.duplicate()
			for item in loop_dict:
				new_texture = load(item.image)
				item.node.get_node('TextureRect').texture = new_texture
	
func _input(event: InputEvent) -> void:
	pass
	#if event is InputEventKey and event.is_action_pressed("move_down"):
		#move_loop()
	#if Input.is_action_just_pressed("move_rigth"):
		#move_loop()
