extends Area2D

@onready var collected_sound: AudioStreamPlayer2D = $CollectedSound
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		PlayersStats.add_key()
		
		visible = false
		collision_shape_2d.set_deferred("disabled", true)
		
		if collected_sound:
			collected_sound.play()
			await collected_sound.finished
		queue_free()
