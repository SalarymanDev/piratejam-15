@tool
extends StaticBody2D

@export var ingredient: IngredientResource
@export var texture: Texture2D
@export var audio_clips: Array[AudioStream]

@onready var item_component: ItemComponent = $ItemComponent
@onready var audio_component: AudioComponent = $AudioComponent
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if ingredient:
		item_component.item = ingredient
	if texture:
		sprite.texture = texture
	if audio_clips:
		audio_component.audio_clips = audio_clips

func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return
	if sprite.texture != texture:
		sprite.texture = texture

func _on_picked_up_event() -> void:
	audio_component.play()
