extends Control

func on_ready():
	$MusikMenu.play()

func _on_play_button_pressed() -> void:
	$MusikMenu.stop()
	get_tree().change_scene_to_file("res://LVL1.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
