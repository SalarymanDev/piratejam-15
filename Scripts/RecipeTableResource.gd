extends Resource
class_name RecipeTableResource

@export var recipes: Array[RecipeResource]
 
var recipe_map: Dictionary = {}


func getRecipes() -> Dictionary:
	for recipe: RecipeResource in recipes:
		recipe_map[recipe.inputs] = recipe.output
	return recipe_map
