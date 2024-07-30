extends Area2D
class_name ClickableComponent

@export var tooltip_text: String

@onready var tooltip: String = tooltip_text

func update_tooltip(text: String) -> void:
	tooltip = text

func _on_mouse_entered() -> void:
	MouseManager.update_tooltip(tooltip)
	MouseManager.show_tooltip(true)
	MouseManager.set_target(get_parent() as Node2D)

func _on_mouse_exited() -> void:
	MouseManager.set_target(null)
	MouseManager.show_tooltip(false)
