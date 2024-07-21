extends Node2D
class_name TakesPotionComponent

@export var destroy: bool = false

func take(_potion: PotionResource) -> void:
	if destroy:
		return
	return
