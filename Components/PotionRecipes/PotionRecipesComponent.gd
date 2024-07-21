extends Node
class_name PotionRecipesComponent

@export var trash_potion: PotionResource
@export var potions: Array[PotionResource]

func create_potion(ingredients: Array[IngredientResource]) -> PotionResource:
	for possible_potion in potions:
		if possible_potion.ingredients.size() != ingredients.size():
			continue
		var success := true
		for needed_ingredient in possible_potion.ingredients:
			var valid_ingredient := false
			for current_ingredient in ingredients:
				if current_ingredient.ingredient == needed_ingredient.ingredient:
					valid_ingredient = true
					break
			if !valid_ingredient:
				success = false
				break
		if success:
			return possible_potion
	
	return trash_potion
