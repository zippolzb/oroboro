extends CharacterBody3D

var gravity = 200
var grid_position := Vector3(0, 0, 0)
var direccion = 'UP'
@export var cell_size := 1.0
@onready var level = get_parent()
@onready var gui = get_parent().get_node('GUI')
@onready var papeles = $"../Mesas/Mesa5"
@onready var biblio = $"../Mesas/Mesa6"
@onready var action = ''
@onready var is_safe_to_act = false
@onready var is_safe_to_talk = false
@onready var game_over_status = false
@onready var victory_node = $"../Sounds/Victory_Sound"
@onready var pasitos_sound = $"../Sounds/Pasitos"
@onready var agarra_sound = $"../Sounds/Agarra"
@onready var suelta_sound = $"../Sounds/Suelta"
@onready var talk_sound = $"../Sounds/Talk"
@onready var game_over_sound = $"../Sounds/GameOver"
@onready var bg_sound = $"../Sounds/BgMusic"

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

func get_object():
	if papeles != $".":
		# cambiar mesh a mesa sin objeto
		papeles.get_child(1).visible = false
		agarra_sound.play()
		# cambiar la layer a mesa sin objeto
		papeles.collision_layer = 5 
		# pasar el objeto al player
		papeles = $"."
	else:
		game_over()

func drop_object(mesa):
	if papeles == $".":
		# cambiar mesh a mesa con objeto
		mesa.get_child(1).visible = true
		suelta_sound.play()
		# cambiar la layer a mesa con objeto
		mesa.collision_layer = 15
		#pasar los papeles a la mesa
		papeles = mesa
	else:
		game_over()
	# cambiar mesh
	# cambiar layer
	# registrar donde esta el item
	
func check_victory():
	if papeles == biblio:
		victory_node.play()
		print("GANASTE CAPO!!!")
		

#func speak_to():
	##check_monster_type() -> monster_type
	##ejecutar_accion_monstruo(monster_type)
	#print("objeto agarrado")

func game_over():
	print("GAME OVER")
	game_over_status = true
	game_over_sound.play()
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()
	
func _physics_process(delta: float) -> void:
	var velocity = Vector3.ZERO
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
	
	var last_pos = global_position
	if game_over_status == false:
		if Input.is_action_just_pressed("reset"):
			get_tree().reload_current_scene()
		if Input.is_action_just_pressed("move_rigth"):
			is_safe_to_act = false
			is_safe_to_talk = false
			position.x += 1
			position.y += 1
			direccion = 'R'
			action = level.checkLoop('R')
			if action == "Mover":
				pasitos_sound.play()
			gui.move_loop()
		if Input.is_action_just_pressed("move_left"):
			is_safe_to_act = false
			is_safe_to_talk = false
			position.y += 0.5
			direccion = 'L'
			position.x -= 1
			action = level.checkLoop('L')
			if action == "Mover":
				pasitos_sound.play()
			gui.move_loop()
		if Input.is_action_just_pressed("move_up"):
			is_safe_to_act = false
			is_safe_to_talk = false
			position.y += 0.5
			direccion = 'U'
			position.z -= 1
			action = level.checkLoop('U')
			if action == "Mover":
				pasitos_sound.play()
			gui.move_loop()
		if Input.is_action_just_pressed("move_down"):
			is_safe_to_act = false
			is_safe_to_talk = false
			position.y += 0.5
			direccion = 'D'
			position.z += 1
			action = level.checkLoop('D')
			if action == "Mover":
				pasitos_sound.play()
			gui.move_loop()
	
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
		#print(str(Time.get_datetime_dict_from_system()) + str(layer))
		var col_dict = {'1':'Wall', '3':'Floor', '5': 'Mesa_sin', '7':'Speaker', '13': 'Biblio', '15': 'Mesa_con'}
		#if layer == 3:
			#pass
		#else:
		if action == 'Mover':
			var chocantes = [1,5,7,13,15]
			if layer in chocantes:
				set_grid_position(last_pos)
				game_over()
		if action == 'Interactuar':
			if layer == 15:
				is_safe_to_act = true
				get_object()
				set_grid_position(last_pos)
			elif layer == 5:
				is_safe_to_act = true
				set_grid_position(last_pos)
				var mesa = collision.get_collider()
				drop_object(mesa)
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
				collision.get_collider().mover(direccion)
			elif layer == 3:
				if is_safe_to_talk == false:
					game_over()
			else:
				game_over()
		#print("Hit Layer: ", layer)
			
		
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
