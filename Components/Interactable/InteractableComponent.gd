extends Area2D
class_name InteractableComponent

signal interacted

func interact() -> void:
	emit_signal(interacted.get_name())
