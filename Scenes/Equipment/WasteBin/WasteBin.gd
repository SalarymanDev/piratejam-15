extends StaticBody2D

@onready var audio_component: AudioComponent = $AudioComponent


func _on_drop_off_ingredient_event(_ingredient: IngredientResource) -> void:
	audio_component.play()

func _on_drop_off_potion_event(_potion: PotionResource) -> void:
	audio_component.play()
