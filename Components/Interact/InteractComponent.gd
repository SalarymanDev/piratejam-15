extends Area2D
class_name InteractComponent

var interactable_in_range: Node2D

func interact() -> void:
	if !interactable_in_range:
		return



func _on_area_entered(area: Area2D) -> void:
	interactable_in_range = area


func _on_area_exited(area: Area2D) -> void:
	interactable_in_range = null
