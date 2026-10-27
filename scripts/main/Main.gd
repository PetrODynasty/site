extends Node2D

@onready var hud: CanvasLayer = $HUD

func _ready() -> void:
	GameManager.start_run()
	if Events.has_signal("run_ended"):
		Events.run_ended.connect(_on_run_ended)

func _on_run_ended(victory: bool) -> void:
	print("Run ended. Victory: ", victory)
	# TODO: show game over/victory screen
	pass
