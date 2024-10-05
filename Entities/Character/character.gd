class_name Character extends CharacterBody2D

@export var sprite: AnimatedSprite2D

### ? Scripts

var move_behavior: CharacterMove = CharacterMove.new()

var behaviors: Dictionary = {
	"character": self,
	"move": move_behavior
}

### ?

### ! Character Stats

@export_subgroup("Stats")
@export var move_speed: float = 200.0

### !

func _ready() -> void:
	move_behavior.character = self

	_start_scripts()

func _start_scripts() -> void:
	move_behavior._ready()

func _process(delta: float) -> void:
	if Input.is_action_pressed("movement"):
		behaviors.move.handle_movement(delta)
