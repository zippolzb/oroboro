extends Node3D
var grid_position := Vector3i(0, 0, 0)
@export var cell_size := 1.0

func set_grid_position(pos: Vector3i):
	grid_position = pos
	global_position = Vector3(
		grid_position.x * cell_size,
		grid_position.y * cell_size,
		grid_position.z * cell_size
	)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
