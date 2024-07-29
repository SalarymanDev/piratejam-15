@tool
extends StaticBody2D

@export var ingredient: IngredientResource
@export var texture: Texture2D
@export var audio_clips: Array[AudioStream]
@export var tooltip: String
@export var instance_scale: float = 1.0

@onready var item_component: ItemComponent = $ItemComponent
@onready var audio_component: AudioComponent = $AudioComponent
@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	assert(texture)
	if Engine.is_editor_hint():
		sprite.texture = texture
		sprite.apply_scale(Vector2(instance_scale, instance_scale))
		return
	assert(ingredient)
	item_component.item = ingredient
	sprite.texture = texture
	if audio_clips:
		audio_component.audio_clips = audio_clips
	if clickable_component:
		clickable_component.update_tooltip(tooltip)
	sprite.apply_scale(Vector2(instance_scale, instance_scale))

func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return
	if sprite.texture != texture:
		sprite.texture = texture

func _on_picked_up_event() -> void:
	audio_component.play()
