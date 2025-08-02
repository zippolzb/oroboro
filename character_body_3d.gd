extends CharacterBody3D

var speed = 18900
var gravity = 900
var grid_position := Vector3(0, 0, 0)
@export var cell_size := 1.0
var normalLoop = [0, 0, 0, 1, 0, 0, 0, 2]
var nextAction = []

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

func check_next_action():
	print(nextAction)
	if nextAction == []: 
		nextAction = normalLoop.duplicate()
	return nextAction[0]
	print(nextAction)

func move(command):
	print("move " + command)
	var current_action = nextAction.pop_front()
	return current_action
func action(command):
	print("action " + command)
	nextAction.pop_front()
	var current_action = nextAction.pop_front()
	return current_action
func speak(command):
	print("speak " + command)
	nextAction.pop_front()
	var current_action = nextAction.pop_front()
	return current_action

func _physics_process(delta: float) -> void:
	var velocity = Vector3.ZERO
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
		
	if Input.is_action_just_pressed("move_rigth"):
		velocity.x += speed
		var nextAction = check_next_action()
		if nextAction == 0:
			var current_action = move("right")
		elif nextAction == 1:
			var current_action =  action("right")
		elif nextAction == 2:
			var current_action = speak("right")
	if Input.is_action_just_pressed("move_left"):
		velocity.x -= speed
		var nextAction = check_next_action()
		if nextAction == 0:
			move("left")
		elif nextAction == 1:
			action("left")
		elif nextAction == 2:
			speak("left")
	if Input.is_action_just_pressed("move_up"):
		velocity.z -= speed
		var nextAction = check_next_action()
		if nextAction == 0:
			move("up")
		elif nextAction == 1:
			action("up")
		elif nextAction == 2:
			speak("up")
	if Input.is_action_just_pressed("move_down"):
		velocity.z += speed
		var nextAction = check_next_action()
		if nextAction == 0:
			move("down")
		elif nextAction == 1:
			action("down")
		elif nextAction == 2:
			speak("down")
		
	
	if global_position.x > 6.5:
		global_position.x = 6.5
	elif global_position.x < 1.5:
		global_position.x = 1.5
	if global_position.z > 6.5:
		global_position.z = 6.5
	elif global_position.z < 1.5:
		global_position.z = 1.5
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		var layer = collider.get_collision_layer()
		var col_dict = {'1':'Wall', '3':'Floor', '7':'Speaker', '15': 'Object'}
		if layer == 3:
			pass
		else:
			print("Hit object: ", collision.get_collider())
			#print("Hit Layer: ", layer)
			print("Hit object: ", col_dict[str(layer)])
			
		
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
	#move_and_slide()
	
