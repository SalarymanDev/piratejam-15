extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var dropoff_component: DropOffComponent = $DropOffComponent
@onready var harvest_sprite: Sprite2D = $HarvestableSprite
@onready var item_component: ItemComponent = $ItemComponent
@onready var pickup_component: PickUpComponent = $PickUpComponent
@onready var takes_ingredients_component: TakesIngredientComponent = $TakesIngredientComponent
@onready var recipe_table_component: RecipeTableComponent = $RecipeTableComponent

@export var cook_timer: int

func _on_drop_off_component_drop_off_ingredient_event(_ingredient: IngredientResource) -> void:
	timer.start(cook_timer)
	dropoff_component.disabled = true
	takes_ingredients_component.disabled = true


func _on_timer_timeout() -> void:
	var input := Array(takes_ingredients_component.get_ingredients(), TYPE_OBJECT, &"Resource", ItemResource)
	var output := recipe_table_component.process_inputs(input) as PotionResource
	item_component.item = output
	harvest_sprite.show()
	pickup_component.disabled = false
	takes_ingredients_component.clear()
	


func _on_pick_up_component_picked_up_event() -> void:
	item_component.item = null
	harvest_sprite.hide()
	dropoff_component.disabled = false
	pickup_component.disabled = true
	takes_ingredients_component.disabled = false
