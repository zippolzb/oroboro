extends Node3D
@onready var player = $CharacterBody3D
@onready var gui = $GUI
@onready var initial_position = Vector3(5,1.25,6)


@onready var action_dict = {0: 'Mover', 1:'Interactuar', 2: 'Hablar'}
#@onready var level_loop = [0, 0, 0, 1, 0, 0, 0, 2]
var level_loop = []
var current_loop = []
var next_action = 0

func _ready() -> void:
	player.global_position = Vector3(0.5,0,0.5) + initial_position
	print("STARTING POSITION: " + str(player.global_position))
	define_level_loop()
	current_loop = level_loop.duplicate()
	next_action = current_loop[0]
	print(level_loop)
	print(current_loop)
	print(next_action)

func define_level_loop():
	for item in gui.level_loop:
		level_loop.append(item.type)

func checkLoop(dir):
	if len(current_loop) == 0:
		current_loop = level_loop.duplicate()
	next_action = current_loop[0]
	current_loop.pop_front()
	print("DEVUELVE: " + next_action)
	return next_action
	
func _process(delta: float) -> void:
	pass
