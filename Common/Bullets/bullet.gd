class_name Bullet extends CharacterBody2D

@export var hitbox: Area2D

@export var initial_speed: float = 240.0
@export var target_speed: float = 240.0
@export var acceleration: float = 0.0
@export var lifespan: float = 1.0
@export var damage: float = 5.0

var is_critical: bool = false
var skill_effect: Callable

var _speed: float = initial_speed
var _direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	_direction = Vector2.RIGHT.rotated(global_rotation)

	hitbox.area_entered.connect(_on_hitbox_area_entered)

	await get_tree().create_timer(lifespan).timeout
	await _before_lifespan_expired()
	queue_free()

func _physics_process(delta: float) -> void:
	_speed = lerp(_speed, target_speed, acceleration * delta)
	velocity = _direction * _speed * delta

	move_and_collide(velocity)

func _before_lifespan_expired() -> void:
	pass

func _on_hitbox_area_entered(_area: Area2D) -> void:
	queue_free()
