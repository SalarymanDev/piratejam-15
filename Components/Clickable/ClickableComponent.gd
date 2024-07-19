extends Area2D

func _on_mouse_entered() -> void:
	MouseManager.set_target(get_parent() as Node2D)

func _on_mouse_exited() -> void:
	MouseManager.set_target(null)
