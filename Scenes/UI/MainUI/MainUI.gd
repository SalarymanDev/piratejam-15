extends Control

@export var time_textures: Array[Texture2D]

@onready var time_indicator: TextureRect = $TimeIndicator
@onready var money_label: Label = $MoneyPaper/HBoxContainer/MoneyLabel
@onready var day_label: Label = $DayPaper/DayLabel

var _current_time_index: int = 0

func _ready() -> void:
	GameStateManager.time_changed_event.connect(_update_time)
	GameStateManager.money_changed_event.connect(_update_money)
	GameStateManager.day_started_event.connect(_update_day)
	_update_day(GameStateManager.get_day())
	_update_money(GameStateManager.get_money())

func _update_time(remaining_seconds: float) -> void:
	var level_seconds := GameStateManager.get_level_seconds()
	var slot_boundry := level_seconds / time_textures.size()
	var time_in_slot := level_seconds - remaining_seconds - (_current_time_index * slot_boundry)
	if time_in_slot >= slot_boundry:
		_current_time_index += 1
		time_indicator.texture = time_textures[_current_time_index]

func _update_money(amount: int) -> void:
	money_label.text = str(amount)

func _update_day(current_day: int) -> void:
	day_label.text = "Day %d" % current_day
