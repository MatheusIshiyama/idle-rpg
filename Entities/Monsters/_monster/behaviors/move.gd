class_name MonsterMove extends CustomNode

var monster: Monster

var sprite: AnimatedSprite2D

func _ready() -> void:
	sprite = monster.sprite

func move_to_target(delta: float) -> void:
	var distance_x: float = monster.target_system.target.global_position.x - monster.global_position.x
	var distance_y: float = monster.target_system.target.global_position.y - monster.global_position.y
	var direction: Vector2 = Vector2.ZERO

	# reduce hypotenuse of a isosceles triangle
	var attack_range: float = monster.attack_range * 0.7
	#

	if (distance_y < -attack_range):
		direction.y -= 1

	if (distance_y > attack_range):
		direction.y += 1

	if (distance_x < -attack_range):
		# sprite.flip_h = true
		direction.x -= 1

	if (distance_x > attack_range):
		# sprite.flip_h = false
		direction.x += 1

	direction *= delta * monster.move_speed
	direction.normalized()

	monster.move_and_collide(direction)

func rotate_to_target() -> void:
	if monster.target_system.target:
		var distance_x: float = monster.target_system.target.global_position.x - monster.global_position.x
		sprite.flip_h = distance_x < 0
