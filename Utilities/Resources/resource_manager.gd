extends CustomNode

var bullet_resources: BulletResources = BulletResources.new()

func _ready() -> void:
	_preload_resources()

func _preload_resources() -> void:
	bullet_resources.preload_resources()

func get_bullet_by_name(bullet_name: String):
	return bullet_resources.get_bullet_by_name(bullet_name)
