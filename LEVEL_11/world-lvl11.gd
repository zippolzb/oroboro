extends Node3D
@onready var player = $CharacterBody3D
@onready var next_level = 'res://LEVEL_7/world-lvl7.tscn'
@onready var bg_sound = $"../Sounds/BgMusic"

# STARTING PLAYER AND ITEMS
@onready var starting_items = [
	# ==== PLAYER ====
	{'node_name': 'Player', 'node': $CharacterBody3D, 'pos': Vector3(6,1.25,6)},
	# ==== ITEMS ====
	{'node_name': 'Libro', 'node': $"Starting-Mesas/Mesa-Libro", 'pos': Vector3(2,1.25,6)},
	{'node_name': 'Cabinet', 'node': $"Starting-Mesas/Mesa-Biblio", 'pos': Vector3(1,1.25,3)},
	# ==== MOBS ====
	{'node_name': 'Mob', 'node': $Mobs/Skeleton, 'pos': Vector3(4,0.5,5)},
	{'node_name': 'Mob-Fanty', 'node': $Mobs/Fanty, 'pos': Vector3(5,0.5,3)},
	# ==== WALLS ====
	{'node_name': 'Mesa', 'node': $Walls/Mesa, 'pos': Vector3(1,1.25,1)},
	{'node_name': 'Mesa', 'node': $Walls/Mesa2, 'pos': Vector3(1,1.25,2)},
	{'node_name': 'Mesa', 'node': $Walls/Mesa3, 'pos': Vector3(1,1.25,4)},
	{'node_name': 'Mesa', 'node': $Walls/Mesa4, 'pos': Vector3(3,1.25,4)},
	{'node_name': 'Mesa', 'node': $Walls/Mesa5, 'pos': Vector3(3,1.25,5)},
	{'node_name': 'Mesa', 'node': $Walls/Mesa6, 'pos': Vector3(4,1.25,1)},
	{'node_name': 'Mesa', 'node': $Walls/Mesa7, 'pos': Vector3(4,1.25,2)},
	{'node_name': 'Mesa', 'node': $Walls/Mesa8, 'pos': Vector3(6,1.25,3)},
]
# DEFINING LOOP
@onready var level_loop_dict = [	
	{'node':$GUI/Move, 'type': 'Mover', 'image':'res://gui/move.png', 'used_image':'res://gui/move_used.png'},
	{'node':$GUI/Move2, 'type': 'Mover', 'image':'res://gui/move.png', 'used_image':'res://gui/move_used.png'},
	{'node':$GUI/Move3, 'type': 'Mover', 'image':'res://gui/move.png', 'used_image':'res://gui/move_used.png'},
	{'node':$GUI/Move4, 'type': 'Mover', 'image':'res://gui/move.png', 'used_image':'res://gui/move_used.png'},
	{'node':$GUI/Move5, 'type': 'Mover', 'image':'res://gui/move.png', 'used_image':'res://gui/move_used.png'},
	{'node':$GUI/Interact, 'type': 'Interactuar', 'image':'res://gui/interact.png', 'used_image':'res://gui/interact_used.png'},
	{'node':$GUI/Move6, 'type': 'Mover', 'image':'res://gui/move.png', 'used_image':'res://gui/move_used.png'},
	{'node':$GUI/Speak, 'type': 'Hablar', 'image':'res://gui/speak.png', 'used_image':'res://gui/speak_used.png'},
]
@onready var action_dict = {0: 'Mover', 1:'Interactuar', 2: 'Hablar'}
var level_loop = []
var current_loop = []
var next_action = 0

func _ready() -> void:
	place_starting_items()
	define_level_loop()
	current_loop = level_loop.duplicate()
	next_action = current_loop[0]
	
func place_starting_items():
	for item in starting_items:
		item['node'].position = item['pos']+Vector3(0.5,0,0.5)
		if item['node_name'] == 'Libro':
			var mesh_libro = item['node'].get_child(1)
			mesh_libro.visible = true
		if item['node_name'] == 'Cabinet':
			var mesh_biblio_biblio = item['node'].get_node('FileCabinet')
			var mesh_biblio_mesa = item['node'].get_child(0)
			mesh_biblio_biblio.visible = true
			mesh_biblio_mesa.visible = false
		if item['node_name'] == 'Cruz':
			var mesh_cruz = item['node'].get_node('Cruz')
			mesh_cruz.visible = true
		
#func define_item_position():
	#var mesh_libro = papeles.get_child(1)
	#mesh_libro.visible = true
	#var mesh_biblio_biblio = biblio.get_child(3)
	#var mesh_biblio_mesa = biblio.get_child(0)
	#mesh_biblio_biblio.visible = true
	#mesh_biblio_mesa.visible = false
	
func define_level_loop():
	for item in level_loop_dict:
		level_loop.append(item.type)

func checkLoop(dir):
	if len(current_loop) == 0:
		current_loop = level_loop.duplicate()
	next_action = current_loop[0]
	current_loop.pop_front()
	return next_action
	
func _process(delta: float) -> void:
	if player.win_status == true:
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file(next_level)
