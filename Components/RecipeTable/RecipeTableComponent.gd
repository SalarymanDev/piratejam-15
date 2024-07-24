extends Node
class_name RecipeTableComponent

@export var default: ItemResource = load("res://Resources/Potions/TrashPotion.tres")
@export var recipes: Dictionary

func process_inputs(inputs: Array[ItemResource]) -> ItemResource:
	if recipes.has(inputs):
		return recipes.get(inputs)
	else:
		return default
