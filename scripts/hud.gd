extends CanvasLayer

var player

@onready var fade_overlay: ColorRect = $FadeOverlay
@onready var pillow_counter: Label = $PillowCounter

func fade(to_alpha: float) -> void:
	var tween:= create_tween()
	tween.tween_property(fade_overlay, "modulate:a", to_alpha, 1.5)
	await tween.finished

func _process(delta: float) -> void:
	if PlayersStats.keys_collected >= PlayersStats.keys_required:
		pillow_counter.text = "Go to bed!"
	else:
		pillow_counter.text = "Pillows: " + str(PlayersStats.keys_collected) + " / " + str(PlayersStats.keys_required) + " to sleep"
