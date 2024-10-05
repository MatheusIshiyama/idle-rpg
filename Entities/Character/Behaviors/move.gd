class_name CharacterMove extends CustomNode

var character: Character
var target_system: CharacterTargetSystem
var sprite: AnimatedSprite2D

func _ready() -> void:
	target_system = character.systems.target_system
	sprite = character.sprite

func handle_movement(delta: float) -> void:
	sprite.play("run")

	var direction: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	if Input.is_action_pressed("move_down"):
		direction.y += 1

	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		sprite.flip_h = true

	if Input.is_action_pressed("move_right"):
		direction.x += 1
		sprite.flip_h = false

	direction *= delta * character.move_speed
	direction.normalized()

	character.move_and_collide(direction)

func move_to_target(delta: float) -> void:
	sprite.play("run")

	var distance_x: float = target_system.target.global_position.x - character.global_position.x
	var distance_y: float = target_system.target.global_position.y - character.global_position.y
	var direction: Vector2 = Vector2.ZERO

	# reduce hypotenuse of a isosceles triangle
	var attack_range: float = character.atk_range * 0.7
	#

	if (distance_y < -attack_range):
		direction.y -= 1

	if (distance_y > attack_range):
		direction.y += 1

	if (distance_x < -attack_range):
		direction.x -= 1
		sprite.flip_h = true

	if (distance_x > attack_range):
		direction.x += 1
		sprite.flip_h = false

	direction *= delta * character.move_speed
	direction.normalized()

	character.position += direction

func rotate_to_target() -> void:
	if target_system.target:
		var distance_x: float = target_system.target.global_position.x - character.global_position.x
		sprite.flip_h = distance_x < 0