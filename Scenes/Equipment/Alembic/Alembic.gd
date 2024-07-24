extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var dropoff_component: DropOffComponent = $DropOffComponent
@onready var harvest_sprite: Sprite2D = $HarvestableSprite
@onready var item_component: ItemComponent = $ItemComponent
@onready var pickup_component: PickUpComponent = $PickUpComponent
@onready var takesingredients_component: TakesIngredientComponent = $TakesIngredientComponent
@onready var recipetable_component: RecipeTableComponent = $RecipeTableComponent
@onready var _original_tooltip := clickable_component.tooltip_text

func _on_drop_off_component_drop_off_ingredient_event(ingredient: IngredientResource) -> void:
	timer.start(3)
	dropoff_component.disabled = true


func _on_timer_timeout() -> void:
	var input := Array(takesingredients_component.get_ingredients(), TYPE_OBJECT, &"Resource", ItemResource)
	var output := recipetable_component.process_inputs(input) as IngredientResource
	item_component.item = output
	harvest_sprite.show()
	pickup_component.disabled = false
	


func _on_pick_up_component_picked_up_event() -> void:
	item_component.item = null
	harvest_sprite.hide()
	dropoff_component.disabled = false
	pickup_component.disabled = true
