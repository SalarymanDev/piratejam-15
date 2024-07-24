extends Control

@onready var money_label: Label = $TextureRect/VBoxContainer/HBoxContainer/MoneyLabel
@onready var rent_label: Label = $TextureRect/VBoxContainer/HBoxContainer2/RentLabel

signal start_day_pressed

func _ready() -> void:
	GameStateManager.money_changed_event.connect(_update_money)
	GameStateManager.rent_changed_event.connect(_update_rent)
	money_label.text = str(GameStateManager._current_money)
	rent_label.text = str(GameStateManager._current_rent)

func _on_start_button_pressed() -> void:
	visible = false
	emit_signal(start_day_pressed.get_name())

func _update_money(amount: int) -> void:
	money_label.text = str(amount)

func _update_rent(amount: int) -> void:
	rent_label.text = str(amount)
