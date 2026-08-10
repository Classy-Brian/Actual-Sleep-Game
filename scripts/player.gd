extends CharacterBody2D

signal died

const SPEED = 300.0

var last_direction: Vector2 = Vector2.RIGHT
var alive: bool = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var woopwoop: AudioStreamPlayer = $woopwoop

func _physics_process(_delta: float) -> void:
	if alive:
		proccess_movement()
		process_animation()
		move_and_slide()

# ------------------------------------------------------------------------------
# MOVEMENT & ANIMATION
# ------------------------------------------------------------------------------
func proccess_movement() -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:	
		velocity = Vector2.ZERO

func process_animation() -> void:
	#if is_attacking:
		#return
	if velocity != Vector2.ZERO:
		play_animation("run", last_direction)
	else:
		play_animation("idle", last_direction)

func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
	
# ------------------------------------------------------------------------------
# GAME OVER STATE
# ------------------------------------------------------------------------------
func get_caught() -> void:
	alive = false
	velocity = Vector2.ZERO # Ensure we stop sliding
	animated_sprite_2d.play("dying")
	woopwoop.play()
	await animated_sprite_2d.animation_finished
	died.emit()

func go_to_sleep():
	alive = false
	velocity = Vector2.ZERO
	animated_sprite_2d.play("sleeping")
