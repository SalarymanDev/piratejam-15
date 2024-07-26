extends Node
class_name RecipeTableComponent

@export var default: ItemResource
@export var recipe_table: RecipeTableResource

func process_inputs(inputs: Array[ItemResource]) -> ItemResource:

	#
	#var recipe_map := recipe_table.getRecipes()
	#inputs.sort()
	#
	#if recipe_map.has(inputs):
		#return recipe_map.get(inputs)
	#else:
		#return default
		
	var recipe_map := recipe_table.getRecipes()
	inputs.sort()
	
	
	var has_recipe: bool = false
	var recipe_key: Array[ItemResource]
	
	# For some reason sorting the input and sorting the key just don't seem to do anything
	# I wrote all this code here just to handle checking if the recipe is right, but I don't think we need it
	
	for key: Array[ItemResource] in recipe_map:	
		if inputs.size() == key.size():
			var working_inputs: Array[ItemResource] = inputs
			
			for i: ItemResource in key:
				var index: int = working_inputs.find(i)
				if index >= 0:
					working_inputs.remove_at(index)
		
			if working_inputs.size() == 0:
				has_recipe = true
				recipe_key = key
	
	if has_recipe:
		return recipe_map.get(recipe_key)
	else:
		return default
