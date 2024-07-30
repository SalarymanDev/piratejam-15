extends Control

@export var time_textures: Array[Texture2D]

@onready var time_indicator: TextureRect = $TimeIndicator
@onready var money_label: Label = $MoneyPaper/HBoxContainer/MoneyLabel
@onready var day_label: Label = $DayPaper/DayLabel
@onready var invisbility_potion_texture: TextureRect = $InvisibilityButton/InvisibilityPotionTexture
@onready var invsibility_potion_button: TextureButton = $InvisibilityButton
@onready var start_day_ui: Control = $StartDayUi
@onready var end_day_ui: Control = $EndDayUi
@onready var potion_use_audio: AudioComponent = $AudioComponent

@onready var first_potion: Label = start_day_ui.get_node("GridContainer/TextureRect/HBoxContainer/Label")
@onready var second_potion: Label = start_day_ui.get_node("GridContainer/TextureRect2/HBoxContainer/Label")
@onready var third_potion: Label = start_day_ui.get_node("GridContainer/TextureRect3/HBoxContainer/Label")

var current_recent_potion: int = 0

func _ready() -> void:
	GameStateManager.time_changed_event.connect(_update_time)
	GameStateManager.money_changed_event.connect(_update_money)
	GameStateManager.day_started_event.connect(_update_day)
	GameStateManager.invisibility_potion_changed.connect(_update_potion)
	_update_day(GameStateManager.get_day())
	_update_money(GameStateManager.get_money())
	_update_potion(GameStateManager.has_invisibility_potion())

func _update_time(remaining_seconds: float) -> void:
	var level_seconds := GameStateManager.get_level_seconds()
	var level_percentage: float = (level_seconds - remaining_seconds) / level_seconds
	var index: int = level_percentage * time_textures.size() as int
	time_indicator.texture = time_textures[index]

func _update_money(amount: int) -> void:
	money_label.text = str(amount)

func _update_day(current_day: int) -> void:
	day_label.text = "Day %d" % current_day

func _update_potion(has_potion: bool) -> void:
	if has_potion:
		invsibility_potion_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		invsibility_potion_button.mouse_default_cursor_shape = Control.CURSOR_ARROW
	invisbility_potion_texture.visible = has_potion

func _on_invisibility_button_pressed() -> void:
	if !GameStateManager.has_invisibility_potion():
		return
	GameStateManager.use_invisibility_potion()
	potion_use_audio.play()

func _on_start_day_pressed() -> void:
	get_tree().paused = false
	GameStateManager.start_day()

func _on_next_day_pressed() -> void:
	start_day_ui.visible = true


func _on_cauldron_potion_crafted(item: PotionResource) -> void:
	
	if(item.potion == Enums.Potions.Trash || item.ingredients.is_empty()):
		return

	var note: String = item.ingredients[0].name
	for i: int in range(1, item.ingredients.size()):
		note = note + " + " + item.ingredients[i].name
	
	note = note + " = " + item.name
	
	if current_recent_potion == 0:
		first_potion.text = note
	elif current_recent_potion == 1:
		second_potion.text = note
	elif current_recent_potion == 2:
		third_potion.text = note
	else:
		current_recent_potion = 0
		first_potion.text = note
	
	current_recent_potion += 1
