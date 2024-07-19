extends Node

var _current_target: Node2D

func set_target(new_target: Node2D) -> void:
	_current_target = new_target

func get_target() -> Node2D:
	return _current_target

func has_target() -> bool:
	return !!_current_target
