extends Control

func _on_texture_button_pressed() -> void:
	PlayersStats.reset()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
