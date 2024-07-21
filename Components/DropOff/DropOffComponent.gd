extends Area2D
class_name DropOffComponent

@export var takes_ingredients_component: TakesIngredientComponent
@export var disabled: bool = false

signal drop_off_event(item: ItemResource)

func _ready() -> void:
	assert(takes_ingredients_component)

func dropoff(item: ItemResource) -> bool:
	if item is IngredientResource:
		if takes_ingredients_component.can_take(item as IngredientResource):
			takes_ingredients_component.take(item as IngredientResource)
			emit_signal(drop_off_event.get_name(), item)
			return true
	return false
