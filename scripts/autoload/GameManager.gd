extends Node

var run_active: bool = false
var current_floor: int = 1
var gold: int = 0
var kills: int = 0

func _ready() -> void:
	Events.enemy_died.connect(_on_enemy_died)
	Events.item_picked_up.connect(_on_item_picked_up)

func start_run() -> void:
	run_active = true
	current_floor = 1
	gold = 0
	kills = 0
	Events.run_started.emit()

func end_run(victory: bool) -> void:
	run_active = false
	Events.run_ended.emit(victory)

func _on_enemy_died(_enemy: Node) -> void:
	if not run_active:
		return
	kills += 1

func _on_item_picked_up(item_data: Resource) -> void:
	pass
