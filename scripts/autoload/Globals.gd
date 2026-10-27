extends Node

const GAME_NAME := "Sealforge Arena: 2D Edition"

var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
