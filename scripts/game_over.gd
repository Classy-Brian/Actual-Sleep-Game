extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_restart_button_pressed() -> void:
	PlayersStats.reset()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
