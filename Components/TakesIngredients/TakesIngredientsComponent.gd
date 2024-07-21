extends Node2D
class_name TakesIngredientComponent

@export var destroy: bool = false
@export var takes_ingredients: Array[IngredientResource]

var _ingredients: Array[IngredientResource] = []

func can_take(ingredient: IngredientResource) -> bool:
	return !_ingredients.has(ingredient)

func take(ingredient: IngredientResource) -> bool:
	if destroy:
		return true
	if !can_take(ingredient):
		return false
	_ingredients.append(ingredient)
	return true
