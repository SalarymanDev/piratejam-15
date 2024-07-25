extends Control

@export var time_textures: Array[Texture2D]

@onready var time_indicator: TextureRect = $TimeIndicator
@onready var money_label: Label = $MoneyPaper/HBoxContainer/MoneyLabel
@onready var day_label: Label = $DayPaper/DayLabel
@onready var invisbility_potion_texture: TextureRect = $InvisibilityButton/InvisibilityPotionTexture
@onready var invsibility_potion_button: TextureButton = $InvisibilityButton
@onready var start_day_ui: Control = $StartDayUi
@onready var end_day_ui: Control = $EndDayUi

var _has_invisiblity_potion: bool = false
# var _current_time_index: int = 0

func _ready() -> void:
	GameStateManager.time_changed_event.connect(_update_time)
	GameStateManager.money_changed_event.connect(_update_money)
	GameStateManager.day_started_event.connect(_update_day)
	_update_day(GameStateManager.get_day())
	_update_money(GameStateManager.get_money())
	_update_potion()

func _update_time(remaining_seconds: float) -> void:
	var level_seconds := GameStateManager.get_level_seconds()
	var level_percentage: float = (level_seconds - remaining_seconds) / level_seconds
	var index: int = level_percentage * time_textures.size() as int
	time_indicator.texture = time_textures[index]

func _update_money(amount: int) -> void:
	money_label.text = str(amount)

func _update_day(current_day: int) -> void:
	day_label.text = "Day %d" % current_day

func _update_potion() -> void:
	if _has_invisiblity_potion:
		invsibility_potion_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		invsibility_potion_button.mouse_default_cursor_shape = Control.CURSOR_ARROW
	invisbility_potion_texture.visible = _has_invisiblity_potion

func _on_invisibility_button_pressed() -> void:
	if !_has_invisiblity_potion:
		return
	_has_invisiblity_potion = false
	_update_potion()

func _on_start_day_pressed() -> void:
	get_tree().paused = false
	GameStateManager.start_day()

func _on_next_day_pressed() -> void:
	start_day_ui.visible = true
