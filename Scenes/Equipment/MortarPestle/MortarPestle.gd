extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var dropoff_component: DropOffComponent = $DropOffComponent
@onready var harvest_sprite: Sprite2D = $HarvestableSprite
@onready var item_component: ItemComponent = $ItemComponent
@onready var pickup_component: PickUpComponent = $PickUpComponent
@onready var takes_ingredients_component: TakesIngredientComponent = $TakesIngredientsComponent
@onready var recipe_table_component: RecipeTableComponent = $RecipeTableComponent
@onready var audio_component: AudioComponent = $AudioComponent
@onready var original_tooltip := clickable_component.tooltip_text

@export var cook_timer: int

func _on_drop_off_component_drop_off_ingredient_event(_ingredient: IngredientResource) -> void:
	timer.start(cook_timer)
	dropoff_component.disabled = true
	takes_ingredients_component.disabled = true
	audio_component.loop()


func _on_timer_timeout() -> void:
	var input := Array(takes_ingredients_component.get_ingredients(), TYPE_OBJECT, &"Resource", ItemResource)
	var output := recipe_table_component.process_inputs(input)
	item_component.item = output
	takes_ingredients_component.clear()
	audio_component.stop()
	
	if item_component.item != null:
		pickup_component.disabled = false
		harvest_sprite.show()
		clickable_component.update_tooltip(output.name)
	else:
		dropoff_component.disabled = false
		takes_ingredients_component.disabled = false


func _on_pick_up_component_picked_up_event() -> void:
	item_component.item = null
	harvest_sprite.hide()
	dropoff_component.disabled = false
	pickup_component.disabled = true
	takes_ingredients_component.disabled = false
	clickable_component.update_tooltip(original_tooltip)
