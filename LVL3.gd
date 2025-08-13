extends Node3D
@onready var player = $CharacterBody3D
@onready var gui = $GUI
@onready var initial_position = Vector3(5,1.25,6)
@onready var papeles = $Mesas/Mesa5
@onready var biblio = $Mesas/Mesa6
@onready var bg_sound = $Sounds/BgMusic

@onready var action_dict = {0: 'Mover', 1:'Interactuar', 2: 'Hablar'}
#@onready var level_loop = [0, 0, 0, 1, 0, 0, 0, 2]
var level_loop = []
var current_loop = []
var next_action = 0

func _ready() -> void:
	player.global_position = Vector3(0.5,0,0.5) + initial_position
	define_level_loop()
	current_loop = level_loop.duplicate()
	next_action = current_loop[0]
	define_item_position()

func define_item_position():
	var mesh_libro = papeles.get_child(1)
	mesh_libro.visible = true
	var mesh_biblio_biblio = biblio.get_child(3)
	var mesh_biblio_mesa = biblio.get_child(0)
	mesh_biblio_biblio.visible = true
	mesh_biblio_mesa.visible = false
	
func define_level_loop():
	for item in gui.level_loop:
		level_loop.append(item.type)

func checkLoop(dir):
	if len(current_loop) == 0:
		current_loop = level_loop.duplicate()
	next_action = current_loop[0]
	current_loop.pop_front()
	return next_action
	
func _process(delta: float) -> void:
	pass
