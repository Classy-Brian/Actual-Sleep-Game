extends Node2D

@onready var hud: CanvasLayer = $HUD

var level: int = 1
var current_level_root: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_level_root = get_node_or_null("LevelRoot")
	_load_level(level)

# ------------------------------------------------------------------------------
# LEVEL MANAGEMENT
# ------------------------------------------------------------------------------
func _load_level(level_number: int) -> void:
	if current_level_root:
		current_level_root.queue_free()
		
	# Change level
	var level_path = "res://scenes/levels/level_%s.tscn" % level_number
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "LevelRoot"
	_setup_level(current_level_root)

func _setup_level(level_root: Node) -> void:
	# Connect Player
	var player = level_root.get_node("Player")
	#$HUD.set_player(player)
	player.died.connect(_on_player_died)
	# Connect exit
	var exit = level_root.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)

# ------------------------------------------------------------------------------
# SIGNAL HANDLERS
# ------------------------------------------------------------------------------
func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Check our global singleton to see if we have enough keys
		if PlayersStats.can_exit():
			print("Escaped! Loading next level...")
			level += 1
			PlayersStats.reset()
			call_deferred("_load_level", level)
		else:
			print("You need more keys! You only have: ", PlayersStats.keys_collected)

func _on_player_died() -> void:
	# Pause for 1 second before resetting eveything
	await get_tree().create_timer(1.0).timeout
	
	if hud and hud.has_method("fade"):
		await hud.fade(1.0)
		
	level = 1
	PlayersStats.reset()
	_load_level(level)
	
	if hud and hud.has_method("fade"):
		await hud.fade(0.0)
