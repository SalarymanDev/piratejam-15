extends Area2D
class_name InteractComponent

var interactable_in_range: InteractableComponent

func interact() -> void:
	if !interactable_in_range:
		return
	interactable_in_range.interact()


func _on_area_entered(area: Area2D) -> void:
	interactable_in_range = area


func _on_area_exited(_area: Area2D) -> void:
	interactable_in_range = null
