extends Area2D
class_name DropOffComponent

@export var takes_ingredients_component: TakesIngredientComponent
@export var takes_potion_component: TakesPotionComponent
@export var disabled: bool = false

signal drop_off_ingredient_event(ingredient: IngredientResource)
signal drop_off_potion_event(potion: PotionResource)

func dropoff(item: ItemResource) -> bool:
	if item is IngredientResource:
		var test: IngredientResource = item
		
		if takes_ingredients_component and takes_ingredients_component.can_take(item as IngredientResource):
			takes_ingredients_component.take(item as IngredientResource)
			emit_signal(drop_off_ingredient_event.get_name(), item as IngredientResource)
			return true
	elif item is PotionResource:
		if takes_potion_component:
			takes_potion_component.take(item as PotionResource)
			emit_signal(drop_off_potion_event.get_name(), item as PotionResource)
			return true
	return false
