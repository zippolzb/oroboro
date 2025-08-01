extends CharacterBody3D

var speed = 60
var gravity = 9.8
var grid_position := Vector3(0, 0, 0)
@export var cell_size := 1.0

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

func _physics_process(delta: float) -> void:
	var input_dir = Vector3.ZERO
	if Input.is_action_just_pressed("move_rigth"):
		input_dir.x += 1
	elif Input.is_action_just_pressed("move_left"):
		input_dir.x -= 1
	elif Input.is_action_just_pressed("move_up"):
		input_dir.z -= 1
	elif Input.is_action_just_pressed("move_down"):
		input_dir.z += 1
	
	print(global_position)
	velocity.x = input_dir.x * speed
	if global_position.x > 6.5:
		global_position.x = 6.5
	elif global_position.x < 1.5:
		global_position.x = 1.5
	if global_position.z > 6.5:
		global_position.z = 6.5
	elif global_position.z < 1.5:
		global_position.z = 1.5
		
	velocity.z = input_dir.z * speed
	print(global_position)
		
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
	move_and_slide()
