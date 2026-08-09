extends CharacterBody2D

const SPEED: int = 100

var target = null

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if target:
		_chase()
	else:
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle")

func _chase() -> void:
	var direction = (target.position - position).normalized()
	velocity = direction * SPEED
	move_and_slide()
	animated_sprite_2d.play("attack")

func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body

func _on_sight_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		target = null

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.has_method("get_caught"):
			body.get_caught()
