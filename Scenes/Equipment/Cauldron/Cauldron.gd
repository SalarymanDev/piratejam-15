extends StaticBody2D

@export var cook_seconds: int

@onready var fire_sprite: Sprite2D = $FireSprite2D
@onready var steam_sprite: Sprite2D = $SteamSprite2D
@onready var star_sprite: Sprite2D = $StarSprite2D
@onready var boil_audio_component: AudioComponent = $BoilAudioComponent
@onready var water_audio_compoent: AudioComponent = $WaterAudioComponent
@onready var splash_audio_component: AudioComponent = $SplashAudioComponent
@onready var fire_audio_component: AudioComponent = $FireAudioComponent
@onready var pickup_audio_component: AudioComponent = $PickupAudioComponent
@onready var takes_ingredients_component: TakesIngredientComponent = $TakesIngredientsComponent
@onready var pickup_component: PickUpComponent = $PickUpComponent
@onready var dropoff_component: DropOffComponent = $DropOffComponent
@onready var item_component: ItemComponent = $ItemComponent
@onready var potion_recipes_component: PotionRecipesComponent = $PotionRecipesComponent
@onready var recipe_table_component: RecipeTableComponent = $RecipeTableComponent
@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var timer: Timer = $Timer
@onready var _original_tooltip := clickable_component.tooltip_text

var _has_water: bool = false
var _has_wood: bool = false

func _on_drop_off_ingredient_event(ingredient: IngredientResource) -> void:
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
	star_sprite.visible = true
	pickup_component.disabled = false
	dropoff_component.disabled = true
	# item_component.item = potion_recipes_component.create_potion(takes_ingredients_component.get_ingredients())
	var inputs := Array(takes_ingredients_component.get_ingredients(), TYPE_OBJECT, &"Resource", ItemResource)
	item_component.item = recipe_table_component.process_inputs(inputs)
	clickable_component.update_tooltip(item_component.item.name)
	takes_ingredients_component.clear()

func _on_picked_up_event() -> void:
	pickup_audio_component.play()
	star_sprite.visible = false
	takes_ingredients_component.disabled = false
	pickup_component.disabled = true
	dropoff_component.disabled = false
	item_component.item = null
	_has_water = false
	_has_wood = false
	clickable_component.update_tooltip(_original_tooltip)
