extends Node
class_name ZIndexComponent

@export var is_static: bool = true

@onready var parent: Node2D = get_parent()

func _ready() -> void:
	parent.z_index = int(parent.global_position.y)
	if is_static:
		process_mode = Node.PROCESS_MODE_DISABLED

func _physics_process(_delta: float) -> void:
	parent.z_index = int(parent.global_position.y)
