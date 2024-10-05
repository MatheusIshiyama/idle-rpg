class_name MonsterTargetSystem extends CustomNode

signal on_death

var monster: Monster

var searching_target: bool = false
var target: Character
var target_hp: float

func find_target() -> void:
	searching_target = true

	for node in get_parent().get_tree().get_root().get_node("Main").get_children():
		if node is Character:
			_handle_closest_target(node)

	if target:
		target.on_death.connect(_on_kill_target)

	searching_target = false

func _handle_closest_target(node) -> void:
	if !target:
		target = node

	var target_distance: float = monster.global_position.distance_to(target.global_position)
	var node_distance: float = monster.global_position.distance_to(node.global_position)

	if target_distance > node_distance:
		target = node

	target_hp = target.max_hp

func _on_kill_target() -> void:
	target.on_death.disconnect(_on_kill_target)
	target = null
