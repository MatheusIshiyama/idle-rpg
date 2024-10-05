class_name CharacterBasicAttack extends Attack

var character: Character
var target_system: CharacterTargetSystem

func _setup() -> void:
	attack_name = "Basic attack"
	description = "Deals 45% of atk as damage"

func _ready() -> void:
	_setup()
	target_system = character.systems.target_system

func use() -> void:
	damage = 5

	var attack = ResourceManager.get_bullet_by_name("arrow")

	if !attack:
		return

	var marker_position: Vector2 = character.bullet_marker.global_position
	var enemy_position: Vector2 = target_system.target.global_position

	var bullet_radius: float = marker_position.angle_to_point(enemy_position)

	attack.rotate(bullet_radius)
	attack.position = marker_position
	attack.damage = damage

	var critical_chance: float = randf_range(0, 100)
	attack.is_critical = critical_chance <= character.critical_chance

	if attack.is_critical:
		attack.damage *= 1 + character.critical_damage / 100

	target_system.target_hp -= attack.damage

	character.get_parent().call_deferred("add_child", attack)
