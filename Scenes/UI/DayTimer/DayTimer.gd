extends Control
class_name DayTimer

@onready var time_remaining_label: Label = $MarginContainer/HBoxContainer/TimeRemainingLabel

func _ready() -> void:
	GameStateManager.time_changed_event.connect(_update_timer_label)
	GameStateManager.day_started_event.connect(_show)
	GameStateManager.day_completed_event.connect(_hide)
	visible = false

func _show() -> void:
	visible = true

func _hide() -> void:
	visible = false

func _update_timer_label(remaining_seconds: float) -> void:
	var minutes: int = int(remaining_seconds) / 60
	var seconds: int = int(remaining_seconds) % 60
	time_remaining_label.text = "%d:%0*d" % [minutes, 2, seconds]
