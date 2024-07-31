extends Area2D
class_name ClickableComponent

@export var tooltip_text: String

@onready var tooltip: String = tooltip_text

var _is_hovered: bool = false

func update_tooltip(text: String) -> void:
	tooltip = text
	if _is_hovered:
		MouseManager.update_tooltip(tooltip)
		MouseManager.show_tooltip(true)

func _on_mouse_entered() -> void:
	_is_hovered = true
	MouseManager.update_tooltip(tooltip)
	MouseManager.show_tooltip(true)
	MouseManager.set_target(get_parent() as Node2D)

func _on_mouse_exited() -> void:
	_is_hovered = false
	MouseManager.set_target(null)
	MouseManager.show_tooltip(false)
