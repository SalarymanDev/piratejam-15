@tool
extends StaticBody2D

@export var ingredient: IngredientResource
@export var texture: Texture2D
@export var audio_clips: Array[AudioStream]
@export var tooltip: String
@export var shouldDisplayEmblem: bool = true
@export var instance_scale: float = 1.0
@export var starts_unlocked: bool = true
@export var key_item: ItemResource

@onready var item_component: ItemComponent = $ItemComponent
@onready var audio_component: AudioComponent = $AudioComponent
@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var pickup_component: PickUpComponent = $PickUpComponent
@onready var dropoff_component: DropOffComponent = $DropOffComponent
@onready var unlock_component: UnlockComponent = $UnlockComponent
@onready var sprite: Sprite2D = $SpawnerSprite
@onready var emblem: Sprite2D = $ItemEmblemSprite

func _ready() -> void:
	assert(texture)
	if Engine.is_editor_hint():
		sprite.texture = texture
		if shouldDisplayEmblem and item_component.item != null:
			emblem.texture = item_component.item.texture
		sprite.apply_scale(Vector2(instance_scale, instance_scale))
		return
	assert(ingredient)
	item_component.item = ingredient
	sprite.texture = texture
	if shouldDisplayEmblem and item_component.item != null:
		emblem.texture = item_component.item.texture
	if audio_clips:
		audio_component.audio_clips = audio_clips
	if clickable_component:
		clickable_component.update_tooltip("%s\n%s" % [item_component.item.name, item_component.item.description])
	sprite.apply_scale(Vector2(instance_scale, instance_scale))
	dropoff_component.disabled = true
	if not starts_unlocked:
		print("locked")
		unlock_component._unlocked = false
		unlock_component._key_item = key_item
		pickup_component.disabled = true
		dropoff_component.disabled = false

func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return
	if sprite.texture != texture:
		sprite.texture = texture
	if shouldDisplayEmblem and item_component.item != null and emblem.texture != item_component.item.texture:
		emblem.texture = item_component.item.texture

func _on_picked_up_event() -> void:
	audio_component.play()


func _on_unlock_component_unlocked() ->  void:
	print("unlocked")
	pickup_component.disabled = false
	dropoff_component.disabled = true
