extends Node
class_name RecipeTableComponent

@export var default: ItemResource
@export var recipe_table: RecipeTableResource

func process_inputs(inputs: Array[ItemResource]) -> ItemResource:
	print(inputs)
	var recipe_map := recipe_table.getRecipes()
	inputs.sort()
	print(inputs)
	print(recipe_map)
	if recipe_map.has(inputs):
		return recipe_map.get(inputs)
	else:
		return default
