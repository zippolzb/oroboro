extends CharacterBody3D
var dir = ''
var speed = 8
@onready var esqueleto_sound = $Node/Esqueleto

@onready var anim_player = $Skeleton/AnimationPlayer

func _ready() -> void:
	anim_player.play('SkeletonIdleWalk_001')

func hablar():
	print("SOY UN ESQUELETO")

func mover(player, direccion):
	dir = direccion
	esqueleto_sound.play()
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
	if global_position.x > 6.5:
		global_position.x = 6.5
		velocity.x = 0
	elif global_position.x < 1.5:
		global_position.x = 1.5
		velocity.x = 0
	elif global_position.z < 1.5:
		global_position.z = 1.5
		velocity.x = 0
	elif global_position.z > 6.5:
		global_position.z = 6.5
		velocity.x = 0
	
	if collision:
		var collider = collision.get_collider()
		var layer = collider.get_collision_layer()
		var col_dict = {'1':'Wall', '3':'Floor', '5': 'Mesa', '7':'Speaker', '13': 'Biblio', '15': 'Object'}
		if layer == 3:
			pass
		else:
			velocity = Vector3.ZERO
		
	
