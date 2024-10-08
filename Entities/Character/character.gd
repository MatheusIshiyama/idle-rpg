class_name Character extends CharacterBody2D

signal on_death

@export var sprite: AnimatedSprite2D
@export var bullet_node: Node2D
@export var bullet_marker: Marker2D

### ? Scripts

var attack_behavior: CharacterAttack = CharacterAttack.new()
var move_behavior: CharacterMove = CharacterMove.new()
var target_system: CharacterTargetSystem = CharacterTargetSystem.new()

var basic_attack: CharacterBasicAttack = CharacterBasicAttack.new()

var behaviors: Dictionary = {
	"character": self,
	"attack": attack_behavior,
	"move": move_behavior
}

var systems: Dictionary = {
	"target_system": target_system
}

### ! Character Base Stats

@export_subgroup("Stats")
@export var base_max_hp: float = 100.0

@export var base_atk: int = 5

@export var base_def: int = 5

@export var is_ranged: bool = true

@export var base_attack_range: float = 50.0

@export var base_attack_speed: float = 5.0

@export var base_move_speed: float = 100.0

### ! Character Stats

var max_hp: float = base_max_hp

var current_hp: float = max_hp

var atk: int = base_atk

var def: int = base_def

var atk_range: float = base_attack_range

var atk_speed: float = base_attack_speed

var move_speed: float = base_move_speed

var critical_chance: float = 5.0

var critical_damage: float = 150.0

### !

func _ready() -> void:
	attack_behavior.character = self
	move_behavior.character = self
	target_system.character = self

	basic_attack.character = self

	_start_scripts()

func _start_scripts() -> void:
	attack_behavior._ready()
	move_behavior._ready()
	
	basic_attack._ready()

	call_deferred("add_child", systems.target_system)

func _process(delta: float) -> void:
	if Input.is_action_pressed("movement"):
		behaviors.move.handle_movement(delta)
	else:
		_handle_idle_behavior(delta)

func _handle_idle_behavior(delta: float) -> void:
	if systems.target_system.target:
		behaviors.move.rotate_to_target()

		var able_to_attack: bool = behaviors.attack.monster_in_attack_range()
		if able_to_attack:
			if sprite.animation != 'attack':
				sprite.play("attack")
		else:
			behaviors.move.move_to_target(delta)

	elif !systems.target_system.searching_target:
		systems.target_system.find_target()

		if sprite.animation != 'idle':
			sprite.play("idle")
