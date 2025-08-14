extends CharacterBody3D

var gravity = 200
var grid_position := Vector3(0, 0, 0)
var direccion = 'UP'
@onready var direccion_dict = {'D': Vector3(0,0,1), 'U': Vector3(0,0,-1), 'R': Vector3(1,0,0), 'L': Vector3(-1,0,0) }
@onready var last_pos = global_position
@export var cell_size := 1.0
@onready var level = get_parent()
@onready var gui = get_parent().get_node('GUI')
@onready var objects_position = {}
@onready var papeles = $"../Starting-Mesas/Mesa-Binder"
@onready var biblio = $"../Starting-Mesas/Mesa-Biblio"
@onready var cruz = null
@onready var hands_full = false
@onready var inventory = ''
@onready var action = ''
@onready var is_safe_to_act = false
@onready var is_safe_to_talk = false
@onready var win_status = false
@onready var game_over_status = false
@onready var pasitos_sound = $"../Sounds/Pasitos"
@onready var victory_node = $"../Sounds/Victory"
@onready var game_over_sound = $"../Sounds/GameOver"
@onready var agarra_sound = $"../Sounds/Agarra"
@onready var suelta_sound = $"../Sounds/Suelta"
@onready var talk_sound = $"../Sounds/Talk"


func _ready():
	if has_node("../Starting-Mesas/Mesa-Cruz"):
		cruz = $"../Starting-Mesas/Mesa-Cruz"
		objects_position = {'Libro': $"../Starting-Mesas/Mesa-Libro", 'biblio': $"../Starting-Mesas/Mesa-Biblio", 'Cruz':$"../Starting-Mesas/Mesa-Cruz"}
	else:
		objects_position = {'Libro': $"../Starting-Mesas/Mesa-Libro", 'biblio': $"../Starting-Mesas/Mesa-Biblio"}
	
func set_grid_position(pos: Vector3):
	grid_position.x = pos.x
	grid_position.z = pos.z
	global_position = Vector3(
		grid_position.x,
		1,
		grid_position.z
	)
	
func move_in_direction(delta: Vector3):
	set_grid_position(grid_position + delta)

func get_object(collider):
	if hands_full == false:
		agarra_sound.play()
		var item_to_check = collider
		var item
		for obj in objects_position:
			if objects_position[obj] == item_to_check:
				item = obj
		# cambiar mesh a mesa sin objeto
		collider.get_node(item).visible = false
		# cambiar la layer a mesa sin objeto
		collider.collision_layer = 5 
		# pasar el objeto al player
		objects_position[item] = $"."
		hands_full = true
		inventory = item
	else:
		game_over()

func drop_object(collider):
	if hands_full == true:
		# cambiar mesh a mesa con objeto
		collider.get_node(inventory).visible = true
		# cambiar la layer a mesa con objeto
		collider.collision_layer = 15
		#pasar los Objeto a la mesa
		objects_position[inventory] = collider
		hands_full = false
		inventory = ''
	else:
		game_over()
	
func check_victory():
	if objects_position['Libro'] == objects_position['biblio']:
		victory_node.play()
		win_status = true
		await get_tree().create_timer(2.0).timeout
		print("GANASTE CAPO!!!")
		

#func speak_to():
	##check_monster_type() -> monster_type
	##ejecutar_accion_monstruo(monster_type)
	#print("objeto agarrado")

func game_over(msg: String = 'GAME OVER'):
	game_over_status = true
	game_over_sound.play()
	print(msg)
	#await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

func normalize_layers():
	for item in level.starting_items:
		if item['node_name'] == 'Mob-Fanty':
			item['node'].collision_layer = 7

func _physics_process(delta: float) -> void:
	var velocity = Vector3.ZERO
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
	
	last_pos = global_position
	if game_over_status == false and win_status == false:
		if Input.is_action_just_pressed("reset"):
			get_tree().reload_current_scene()
		if Input.is_action_just_pressed("move_rigth"):
			is_safe_to_act = false
			is_safe_to_talk = false
			position.x += 1
			position.y += 1
			direccion = 'R'
			action = level.checkLoop('R')
			gui.move_loop()
			if action == "Mover":
				pasitos_sound.play()
				normalize_layers()
		if Input.is_action_just_pressed("move_left"):
			is_safe_to_act = false
			is_safe_to_talk = false
			position.x -= 1
			position.y += 0.5
			direccion = 'L'
			action = level.checkLoop('L')
			gui.move_loop()
			if action == "Mover":
				pasitos_sound.play()
				normalize_layers()
		if Input.is_action_just_pressed("move_up"):
			is_safe_to_act = false
			is_safe_to_talk = false
			position.z -= 1
			position.y += 0.5
			direccion = 'U'
			action = level.checkLoop('U')
			gui.move_loop()
			if action == "Mover":
				pasitos_sound.play()
				normalize_layers()
		if Input.is_action_just_pressed("move_down"):
			is_safe_to_act = false
			is_safe_to_talk = false
			position.z += 1
			position.y += 0.5
			direccion = 'D'
			action = level.checkLoop('D')
			gui.move_loop()
			if action == "Mover":
				pasitos_sound.play()
				normalize_layers()
		
	var collision = move_and_collide(velocity * delta)
	if global_position.x > 6.5:
		global_position.x = 6.5
	elif global_position.x < 1.5:
		global_position.x = 1.5
	if global_position.z > 6.5:
		global_position.z = 6.5
	elif global_position.z < 1.5:
		global_position.z = 1.5
	
	if collision:
		
		var collider = collision.get_collider()
		var layer = collider.get_collision_layer()
		var col_dict = {'1':'Wall', '3':'Floor', '5': 'Mesa_sin', '7':'Speaker', '13': 'Biblio', '15': 'Mesa_con'}
		if action == 'Mover':
			var chocantes = [1,5,7,13,15]
			var vampi_check = collider.name.substr(0, 5)
			if layer in chocantes:
				if layer == 7 and vampi_check == 'Vampi':
					collision.get_collider().empujar(self, direccion)
					#set_grid_position(last_pos)
				elif layer == 7 and vampi_check == 'Fanty':
					if gui.loop_dict[0]['type'] == 'Mover':
						collision.get_collider().traspasar(self, direccion)
					else:
						game_over("GAME OVER: CAMINAR EN FANTASMAS CUESTA 2 MOVIMIENTOS")
				else:
					set_grid_position(last_pos)
					game_over()
		if action == 'Interactuar':
			if layer == 15:
				is_safe_to_act = true
				get_object(collider)
				set_grid_position(last_pos)
			elif layer == 5:
				is_safe_to_act = true
				set_grid_position(last_pos)
				collision.get_collider()
				drop_object(collision.get_collider())
			elif layer == 13:
				var biblio = collision.get_collider()
				drop_object(biblio)
				is_safe_to_act = true
				set_grid_position(last_pos)
				check_victory()
			elif layer == 3:
				if is_safe_to_act == false:
					game_over()
				else:
					pass
			else: 
				game_over()
		if action == 'Hablar':
			if layer == 7:
				talk_sound.play()
				is_safe_to_talk = true
				set_grid_position(last_pos+Vector3(0,0,0))
				await get_tree().create_timer(1.0).timeout
				collision.get_collider().mover(self,direccion)
			elif layer == 3:
				if is_safe_to_talk == false:
					game_over()
			else:
				game_over()
			
		
#func _physics_process(delta: float) -> void:
	#var input_dir = Vector3.ZERO
	#if Input.is_action_just_pressed("move_rigth"):
		#input_dir.x += 1
	#elif Input.is_action_just_pressed("move_left"):
		#input_dir.x -= 1
	#elif Input.is_action_just_pressed("move_up"):
		#input_dir.z -= 1
	#elif Input.is_action_just_pressed("move_down"):
		#input_dir.z += 1
	#
	#if global_position.x > 6.5:
		#global_position.x = 6.5
	#elif global_position.x < 1.5:
		#global_position.x = 1.5
	#if global_position.z > 6.5:
		#global_position.z = 6.5
	#elif global_position.z < 1.5:
		#global_position.z = 1.5
	#
	#velocity.x = input_dir.x * delta
	#velocity.z = input_dir.z * delta
	#print(global_position)
	#
	#var collision = move_and_collide(velocity * delta * speed)
	#
	#if collision:
		#print(collision.get_collider())
		#
	#if not is_on_floor():
		#velocity.y -= gravity * delta
	#else:
		#velocity.y = 0
