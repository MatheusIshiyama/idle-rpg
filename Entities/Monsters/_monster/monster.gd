class_name Monster extends CharacterBody2D

signal on_death

var move_behavior: MonsterMove = MonsterMove.new()
var target_system: MonsterTargetSystem = MonsterTargetSystem.new()

var behaviors: Dictionary = {
	"move": move_behavior
}

var systems: Dictionary = {
	"target_system": target_system
}

@export var sprite: AnimatedSprite2D

### ! Monster Info

@export var monster_name: String

### ! Monster Base Stats

@export_subgroup("Stats")
@export var base_max_hp: float = 10.0

@export var base_atk: int = 5

@export var base_def: int = 5

@export var is_ranged: bool = true

@export var base_attack_range: float = 15.0

@export var base_attack_speed: float = 5.0

@export var base_move_speed: float = 25.0

### ! Monster Stats

var max_hp: float = base_max_hp

var current_hp: float = max_hp

var atk: int = base_atk

var def: int = base_def

var attack_range: float = base_attack_range

var attack_speed: float = base_attack_speed

var move_speed: float = base_move_speed

var critical_chance: float = 5.0

var critical_damage: float = 150.0

### !

func _ready() -> void:
	move_behavior.monster = self
	target_system.monster = self

	_load_scripts()

func _load_scripts() -> void:
	move_behavior._ready()

	call_deferred("add_child", systems.target_system)

func _process(delta: float) -> void:
	if target_system.target:
		behaviors.move.move_to_target(delta)
	else:
		systems.target_system.find_target()
