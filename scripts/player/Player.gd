extends CharacterBody2D
class_name Player

@export var move_speed: float = 200.0
@export var max_health: int = 100
var current_health: int = max_health

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Hitbox
@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	current_health = max_health
	Events.player_health_changed.emit(current_health, max_health)

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	velocity = input_vector * move_speed
	move_and_slide()
	
	if velocity.length() > 0:
		if animation_player.has_animation("run"):
			animation_player.play("run")
	else:
		if animation_player.has_animation("idle"):
			animation_player.play("idle")
	
	if Input.is_action_just_pressed("attack"):
		attack()

func attack() -> void:
	if animation_player.has_animation("attack"):
		animation_player.play("attack")

func take_damage(amount: int) -> void:
	current_health -= amount
	current_health = max(0, current_health)
	Events.player_damaged.emit(amount)
	Events.player_health_changed.emit(current_health, max_health)
	if current_health <= 0:
		die()

func die() -> void:
	Events.player_died.emit()
	GameManager.end_run(false)
	set_physics_process(false)
	if animation_player.has_animation("death"):
		animation_player.play("death")
	else:
		queue_free()
