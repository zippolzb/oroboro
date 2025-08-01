extends Node3D
@onready var player = $Player  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_grid_position(Vector3i(-1, 1, -1))  # Start position
	
func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		print(player.grid_position)
		if event.keycode == KEY_W:
			if player.grid_position.z == -5:
				pass
			else:
				player.move_in_direction(Vector3i(0, 0, -2))
		elif event.keycode == KEY_S:
			if player.grid_position.z == 5:
				pass
			else:
				player.move_in_direction(Vector3i(0, 0, 2))
		elif event.keycode == KEY_A:
			if player.grid_position.x == -5:
				pass
			else:
				player.move_in_direction(Vector3i(-2, 0, 0))
		elif event.keycode == KEY_D:
			if player.grid_position.x == 5:
				pass
			else:
				player.move_in_direction(Vector3i(2, 0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
