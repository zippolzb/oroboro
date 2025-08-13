extends CharacterBody3D
var dir = ''
var speed = 18900

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
	var direcciones = {'D': Vector3(0,0,1), 'U': Vector3(0,0,-1), 'R': Vector3(1,0,0), 'L': Vector3(-1,0,0) }
	var vampi_pos = self.global_position + direcciones[direccion]
	if player.inventory == 'Cruz':
		if check_if_occupied(vampi_pos):
			player.set_grid_position(player.last_pos)
		else:
			global_position = vampi_pos
	else:
		print("NO JODAS!")


func check_if_occupied(pos: Vector3):
	var space_state = get_world_3d().direct_space_state
	var params = PhysicsShapeQueryParameters3D.new()
	var checking_pos = pos + Vector3(0,0.75,0)
	params.shape = SphereShape3D.new()
	params.shape.radius = 0.25
	params.transform = Transform3D(Basis(), checking_pos)
	
	var result = space_state.intersect_shape(params, 1)
	print(pos)
	print(params)
	print(result)
	return result.size() > 0
	
