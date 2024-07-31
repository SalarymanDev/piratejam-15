extends Control

@onready var money_label: Label = $TextureRect/VBoxContainer/HBoxContainer4/MoneyLabel
@onready var rent_label: Label = $TextureRect/VBoxContainer/HBoxContainer2/RentLabel
@onready var revenue_label: Label = $TextureRect/VBoxContainer/HBoxContainer/RevenueLabel
@onready var profit_label: Label = $TextureRect/VBoxContainer/HBoxContainer3/ProfitLabel
@onready var day_label: Label = $TextureRect/VBoxContainer/DayLabel

signal next_day_pressed

func _ready() -> void:
	GameStateManager.day_completed_event.connect(_on_day_completed)

func _on_day_completed(revenue: int, rent: int, profit: int, money: int) -> void:
	get_tree().paused = true
	day_label.text = "Day %d" % GameStateManager.get_day()
	revenue_label.text = str(revenue)
	rent_label.text = str(rent)
	profit_label.text = str(profit)
	money_label.text = str(money)
	visible = true

func _on_next_button_pressed() -> void:
	visible = false
	emit_signal(next_day_pressed.get_name())
