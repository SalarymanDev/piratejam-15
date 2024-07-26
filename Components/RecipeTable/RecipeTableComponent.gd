extends Node
class_name RecipeTableComponent

@export var default: ItemResource
@export var recipe_table: RecipeTableResource

func process_inputs(inputs: Array[ItemResource]) -> ItemResource:
	var recipe_map := recipe_table.getRecipes()
	inputs.sort_custom(RecipeResource.sort_by_name)
	
	if recipe_map.has(inputs):
		return recipe_map.get(inputs)
	else:
		return default
