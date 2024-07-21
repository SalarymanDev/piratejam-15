extends StaticBody2D

@export var cook_seconds: int
@export var test_item: ItemResource

@onready var fire_sprite: Sprite2D = $FireSprite2D
@onready var steam_sprite: Sprite2D = $SteamSprite2D
@onready var star_sprite: Sprite2D = $StarSprite2D
@onready var boil_audio_component: AudioComponent = $BoilAudioComponent
@onready var water_audio_compoent: AudioComponent = $WaterAudioComponent
@onready var splash_audio_component: AudioComponent = $SplashAudioComponent
@onready var fire_audio_component: AudioComponent = $FireAudioComponent
@onready var takes_ingredients_component: TakesIngredientComponent = $TakesIngredientsComponent
@onready var pickup_component: PickUpComponent = $PickUpComponent
@onready var dropoff_component: DropOffComponent = $DropOffComponent
@onready var item_component: ItemComponent = $ItemComponent
@onready var timer: Timer = $Timer

var _has_water: bool = false
var _has_wood: bool = false

func _on_drop_off_event(item: ItemResource) -> void:
	var ingredient := item as IngredientResource
	match ingredient.ingredient:
		Enums.Ingredients.Water:
			_has_water = true
			water_audio_compoent.play()
			_handle_boil_audio()
			return
		Enums.Ingredients.Wood:
			_has_wood = true
			fire_sprite.visible = true
			fire_audio_component.play()
			fire_sprite.visible = true
			_handle_boil_audio()
			return
	
	if _has_water:
		splash_audio_component.play()

func _handle_boil_audio() -> void:
	if _has_water and _has_wood:
		steam_sprite.visible = true
		boil_audio_component.play()
		timer.start(cook_seconds)
		takes_ingredients_component.disabled = true

func _on_timer_timeout() -> void:
	fire_sprite.visible = false
	steam_sprite.visible = false
	fire_audio_component.stop()
	boil_audio_component.stop()
	takes_ingredients_component.clear()
	star_sprite.visible = true
	pickup_component.disabled = false
	dropoff_component.disabled = true
	item_component.item = test_item

func _on_picked_up_event() -> void:
	star_sprite.visible = false
	takes_ingredients_component.disabled = false
	pickup_component.disabled = true
	dropoff_component.disabled = false
	item_component.item = null
