extends Node3D
@onready var player = $CharacterBody3D


#func _unhandled_input(event):
	#if event is InputEventKey and event.pressed:
		#print(player.global_position)
		#if event.keycode == KEY_W:
			#player.move_in_direction(Vector3i(0, 0, -1))
		#if event.keycode == KEY_S:
			#player.move_in_direction(Vector3i(0, 0, 1))
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.global_position= Vector3(5.5, 2, 6.5)
	print("starting: " + str(player.global_position)) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
