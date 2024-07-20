extends Control
class_name DayTimer

@export var max_time_seconds: int = 300

@onready var time_remaining_label: Label = $MarginContainer/HBoxContainer/TimeRemainingLabel
@onready var timer: Timer = $Timer

signal day_started
signal day_completed

func _ready() -> void:
	_update_timer_label(max_time_seconds)
	timer.timeout.connect(_stop)
	start()

func start() -> void:
	emit_signal(day_started.get_name())
	timer.start(max_time_seconds)

func _stop() -> void:
	timer.stop()
	_update_timer_label(0)
	emit_signal(day_completed.get_name())

func _physics_process(_delta: float) -> void:
	if timer.is_stopped():
		return
	_update_timer_label(ceili(timer.time_left))

func _update_timer_label(remaining_seconds: int) -> void:
	var minutes: int = remaining_seconds / 60
	var seconds: int = remaining_seconds % 60
	time_remaining_label.text = "%d:%0*d" % [minutes, 2, seconds]
