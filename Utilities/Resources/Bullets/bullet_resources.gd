class_name BulletResources extends CustomNode

var _resources: Dictionary = {}

func get_bullet_by_name(bullet_name: String):
	if _resources.has(bullet_name):
		return _resources[bullet_name].instantiate()

func preload_resources() -> void:
	_resources.arrow = preload("res://Common/Bullets/Arrow/arrow.tscn")
