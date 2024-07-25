extends Area2D
class_name ClickableComponent

@export var tooltip_text: String

@onready var label: Label = $Label

func _ready() -> void:
	label.visible = false
	label.text = tooltip_text

func update_tooltip(text: String) -> void:
	label.text = text

func _on_mouse_entered() -> void:
	label.visible = true
	MouseManager.set_target(get_parent() as Node2D)

func _on_mouse_exited() -> void:
	label.visible = false
	MouseManager.set_target(null)
