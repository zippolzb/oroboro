extends Node3D
@onready var player = $CharacterBody3D


@onready var action_dict = {0: 'Mover', 1:'Interactuar', 2: 'Hablar'}
@onready var level_loop = [0, 0, 0, 1, 0, 0, 0, 2]
@onready var current_loop = [0, 0, 0, 1, 0, 0, 0, 2]
@onready var next_action = current_loop[0]


func checkLoop(dir):
	if len(current_loop) == 0:
		current_loop = level_loop.duplicate()
	next_action = current_loop[0]
	print("LOOP: " + action_dict[next_action] + dir)
	current_loop.pop_front()

func _process(delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("move_rigth"):
		#checkLoop('R')
	#if Input.is_action_just_pressed("move_left"):
		#checkLoop('L')
	#if Input.is_action_just_pressed("move_up"):
		#checkLoop('U')
	#if Input.is_action_just_pressed("move_down"):
		#checkLoop('D')
	
	
	
	


#func _unhandled_input(event):
	#if event is InputEventKey and event.pressed:
		#print(player.global_position)
		#if event.keycode == KEY_W:
			#player.move_in_direction(Vector3i(0, 0, -1))
		#if event.keycode == KEY_S:
			#player.move_in_direction(Vector3i(0, 0, 1))
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.global_position= Vector3(5.5, 2, 6.5)
	print("starting: " + str(player.global_position)) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
