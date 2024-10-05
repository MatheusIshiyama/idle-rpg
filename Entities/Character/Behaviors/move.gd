class_name CharacterMove extends CustomNode

var character: Character
var sprite: AnimatedSprite2D

func _ready() -> void:
	sprite = character.sprite

func handle_movement(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	if Input.is_action_pressed("move_down"):
		direction.y += 1

	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	if Input.is_action_pressed("move_right"):
		direction.x += 1

	direction *= delta * character.move_speed
	direction.normalized()

	character.move_and_collide(direction)
