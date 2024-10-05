class_name CharacterAttack extends CustomNode

var character: Character
var sprite: AnimatedSprite2D
var target_system: CharacterTargetSystem

var attack_animation_frames: int = 6

var _attack_animation_speed: float = 0

func _ready() -> void:
	sprite = character.sprite
	target_system = character.systems.target_system

	attack_animation_frames = sprite.sprite_frames.get_frame_count("attack")

	if !sprite.animation_looped.is_connected(_on_sprite_animation_looped):
		sprite.animation_looped.connect(_on_sprite_animation_looped)

func _process(_delta: float) -> void:
	if _attack_animation_speed != character.atk_speed:
		_update_attack_animation_speed()

func _update_attack_animation_speed() -> void:
	var attack_animation_speed: float = character.atk_speed * attack_animation_frames

	sprite.sprite_frames.set_animation_speed("attack", attack_animation_speed)

	_attack_animation_speed = character.atk_speed

func monster_in_attack_range() -> bool:
	var target: Monster = target_system.target
	var distance: float = character.global_position.distance_to(target.global_position)

	return distance <= character.atk_range

func _on_sprite_animation_looped() -> void:
	var target: Monster = target_system.target
	var target_is_valid: bool = target && target_system.target_hp > 0

	if target_is_valid && sprite.animation == 'attack':
		_handle_attack()

func _handle_attack() -> void:
	character.basic_attack.use()
