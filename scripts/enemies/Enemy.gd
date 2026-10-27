extends CharacterBody2D
class_name Enemy

@export var max_health: int = 30
@export var move_speed: float = 80.0
@export var damage: int = 10
@export var chase_range: float = 200.0

var current_health: int
var player: Player
var aggro: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	current_health = max_health
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta: float) -> void:
	if player == null:
		return
	var dist := global_position.distance_to(player.global_position)
	if dist <= chase_range:
		aggro = true
	if aggro:
		var dir := (player.global_position - global_position).normalized()
		velocity = dir * move_speed
		move_and_slide()
		if velocity.length() > 0 and animation_player.has_animation("run"):
			animation_player.play("run")
		elif velocity.length() == 0 and animation_player.has_animation("idle"):
			animation_player.play("idle")

func take_damage(amount: int) -> void:
	current_health -= amount
	Events.enemy_damaged.emit(self, amount)
	if current_health <= 0:
		die()

func die() -> void:
	Events.enemy_died.emit(self)
	if animation_player.has_animation("death"):
		animation_player.play("death")
		await animation_player.animation_finished
	queue_free()
