extends CharacterBody3D
var dir = ''
var speed = 18900

@onready var anim_player = $Ghost_main/AnimationPlayer
@onready var anim_player2 = $"Ghost-trans/AnimationPlayer"
@onready var audio = $AudioStreamPlayer2D

func _ready() -> void:
	anim_player.play('GhostIdle')
	anim_player2.play('GhostIdle')
	

func traspasar(player, direccion):
	self.collision_layer = 6
	print(self)
	self.get_node('Ghost_main').visible = false
	self.get_node('Ghost-trans').visible = true
	player.gui.move_loop()
	player.level.checkLoop(direccion)
	player.set_grid_position(player.last_pos + player.direccion_dict[direccion])
	audio.play()

func empujar(player, direccion):
	var direcciones = {'D': Vector3(0,0,1), 'U': Vector3(0,0,-1), 'R': Vector3(1,0,0), 'L': Vector3(-1,0,0) }
	var vampi_pos = self.global_position + direcciones[direccion]
	var player_pos = self.global_position
	if player.inventory == 'Cruz':
		if check_if_occupied(vampi_pos):
			player.set_grid_position(player.last_pos)
		else:
			global_position = vampi_pos
			player.global_position = player_pos
	else:
		player.set_grid_position(player.last_pos)
		player.game_over()

func mover(player, direccion):
	var direcciones = {'D': Vector3(0,0,2), 'U': Vector3(0,0,-2), 'R': Vector3(2,0,0), 'L': Vector3(-2,0,0) }
	var fanty_pos = self.global_position + direcciones[direccion]
	fanty_pos.x = clamp(fanty_pos.x, 1.5 , 6.5)
	fanty_pos.y = clamp(fanty_pos.y, 0 , 6.5)
	fanty_pos.z = clamp(fanty_pos.z, 1.5 , 6.5)
	print(fanty_pos)
	global_position = fanty_pos

func check_if_occupied(pos: Vector3):
	var space_state = get_world_3d().direct_space_state
	var params = PhysicsShapeQueryParameters3D.new()
	var checking_pos = pos + Vector3(0,0.75,0)
	params.shape = SphereShape3D.new()
	params.shape.radius = 0.5
	params.transform = Transform3D(Basis(), checking_pos)
	
	var result = space_state.intersect_shape(params, 1)
	return result
