extends CharacterBody3D
var grid_position := Vector3(0, 0, 0)
var dir = ''
var speed = 18900

func hablar():
	print("SOY UN ESQUELETO")

func set_grid_position(pos: Vector3):
	print("SOY UN ESQUELETO")
	grid_position.x = pos.x
	grid_position.z = pos.z
	global_position = Vector3(
		grid_position.x,
		1,
		grid_position.z
	)
	
func mover(direccion):
	dir = direccion
	
func _physics_process(delta: float) -> void:
	var velocity = Vector3.ZERO
	if dir == 'R':
		velocity.x += speed
	if dir == 'L':
		velocity.x -= speed
	if dir == 'D':
		velocity.z += speed
	if dir == 'U':
		velocity.z -= speed
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		var layer = collider.get_collision_layer()
		var col_dict = {'1':'Wall', '3':'Floor', '5': 'Mesa', '7':'Speaker', '13': 'Biblio', '15': 'Object'}
		if layer == 3:
			pass
		else:
			velocity = Vector3.ZERO
		
	
