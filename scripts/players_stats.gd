extends Node

var keys_collected: int = 0
var keys_required: int = 3

func add_key() -> void:
	keys_collected += 1
	print("Keys: ", keys_collected, " / ", keys_required)

func can_exit() -> bool:
	return keys_collected >= keys_required

func reset() -> void:
	keys_collected = 0
