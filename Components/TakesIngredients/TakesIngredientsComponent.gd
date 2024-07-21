extends Node2D
class_name TakesIngredientComponent

@export var destroy: bool = false
@export var cauldron: bool = false
@export var disabled: bool = false
@export var takes_ingredients: Array[IngredientResource]

var _ingredients: Array[IngredientResource] = []

func can_take(ingredient: IngredientResource) -> bool:
	if disabled:
		return false
	if cauldron:
		return _can_take_cauldron(ingredient)
	return !_ingredients.has(ingredient)

func take(ingredient: IngredientResource) -> bool:
	if disabled:
		return false
	if destroy:
		return true
	if !can_take(ingredient):
		return false
	
	_ingredients.append(ingredient)
	return true

func get_ingredients() -> Array[IngredientResource]:
	return _ingredients

func clear() -> void:
	_ingredients.clear()

func _can_take_cauldron(ingredient: IngredientResource) -> bool:
	if _ingredients.size() == 0 and ingredient.ingredient != Enums.Ingredients.Water:
		return false
	if _ingredients.size() > 0 and ingredient.ingredient == Enums.Ingredients.Water:
		return false
	return true

