extends Control

const IMAGE_SIZE = Vector2(100,100)
@onready var level_loop = [
	{'node':$Move1, 'type': 'Mover', 'state':1, 'image':'res://test_assets/Move.png', 'used_image':'res://test_assets/Move_used.png'},
	{'node':$Move2, 'type': 'Mover', 'state':0, 'image':'res://test_assets/Move.png', 'used_image':'res://test_assets/Move_used.png'},
	{'node':$Move3, 'type': 'Mover', 'state':0, 'image':'res://test_assets/Move.png', 'used_image':'res://test_assets/Move_used.png'},
	{'node':$Interact, 'type': 'Interactuar', 'state':0, 'image':'res://test_assets/Interact.png', 'used_image':'res://test_assets/Interact_used.png'},
	{'node':$Move4, 'type': 'Mover', 'state':0, 'image':'res://test_assets/Move.png', 'used_image':'res://test_assets/Move_used.png'},
	{'node':$Move5, 'type': 'Mover', 'state':0, 'image':'res://test_assets/Move.png', 'used_image':'res://test_assets/Move_used.png'},
	{'node':$Move6, 'type': 'Mover', 'state':0, 'image':'res://test_assets/Move.png', 'used_image':'res://test_assets/Move_used.png'},
	{'node':$Speak, 'type': 'Hablar', 'state':0, 'image':'res://test_assets/Speak.png', 'used_image':'res://test_assets/Speak_used.png'}	
]
@onready var loop_dict = level_loop.duplicate()

func _ready():
	var count = 0
	for item in level_loop:
		var size = 105
		var x_pos = size*count
		count = count + 1
		setup_margin_container(item.node, x_pos, 0, IMAGE_SIZE)

func setup_margin_container(node: MarginContainer, x: int, y: int, size: Vector2):
	node.size = size
	node.position = Vector2(x, y)

#func move_loop2():
	#for item in loop_dict:
		#if item.node

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

#.node.get_node('TextureRect')
