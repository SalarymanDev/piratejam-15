extends Node
class_name RecipeTableComponent

@export var default: ItemResource
@export var recipe_table: RecipeTableResource

func process_inputs(inputs: Array[ItemResource]) -> ItemResource:
	#print(inputs[0].name)
	#print(inputs[1].name)
	#print(inputs[2].name)
	
	var recipe_map := recipe_table.getRecipes()
	inputs.sort()
	
	#for key: Variant in recipe_map:
		#for i: Variant in key:
			#print(i.name)
		#print(" ")
		
	#for key: Array[ItemResource] in recipe_map:
		#for i: int in range(0, key.size()):
			#print(key[i].name + " " + inputs[i].name)
		#print(" ")
			
	if recipe_map.has(inputs):
		return recipe_map.get(inputs)
	else:
		return default
