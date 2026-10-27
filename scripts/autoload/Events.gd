extends Node

# Player
signal player_damaged(amount: int)
signal player_died
signal player_health_changed(current: int, max_health: int)

# Combat
signal enemy_damaged(enemy: Node, amount: int)
signal enemy_died(enemy: Node)

# Game flow
signal room_cleared
signal run_started
signal run_ended(victory: bool)
signal game_paused(paused: bool)

# Items/Loot
signal item_picked_up(item_data: Resource)
signal gold_changed(amount: int)
