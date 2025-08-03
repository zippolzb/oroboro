extends Control

func on_ready():
	$Victory.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
