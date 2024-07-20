extends Node
class_name ZIndexComponent

@export var sprite: Sprite2D
@export var is_static: bool = true

func _ready() -> void:
	sprite.z_index = int(sprite.global_position.y)
	if is_static:
		process_mode = Node.PROCESS_MODE_DISABLED

func _physics_process(_delta: float) -> void:
	sprite.z_index = int(sprite.global_position.y)
