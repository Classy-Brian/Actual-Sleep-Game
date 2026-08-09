extends Control

func _on_start_pressed() -> void:
	# Loads to level manager
	get_tree().change_scene_to_file("res://scenes/main.tscn")
