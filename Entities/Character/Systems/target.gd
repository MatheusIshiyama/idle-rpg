class_name CharacterTargetSystem extends CustomNode

var character: Character

var searching_target: bool = false
var target: Monster
var target_hp: float

func reset_target() -> void:
	if target:
		target.on_death.disconnect(_on_kill_target)
		target = null

func find_target() -> void:
	searching_target = true
  
	var parent_node: Node = character.get_parent()

	if parent_node.name != "Main":
		print("diff: ", parent_node.name)
		searching_target = false
		return

	for node in parent_node.get_children():
		if node is Monster:
			_handle_closest_target(node)

	if target:
		target.on_death.connect(_on_kill_target)

	searching_target = false

func _handle_closest_target(node) -> void:
	if !target:
		target = node

	var target_distance: float = character.global_position.distance_to(target.global_position)
	var node_distance: float = character.global_position.distance_to(node.global_position)

	if target_distance > node_distance:
		target = node

	target_hp = target.max_hp

func _on_kill_target() -> void:
	target.on_death.disconnect(_on_kill_target)
	target = null
