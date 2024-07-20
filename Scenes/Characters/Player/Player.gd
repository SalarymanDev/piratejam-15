extends CharacterBody2D

@onready var navigation_component: NavigationComponent = $NavigationComponent

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	_handle_movement_input(event as InputEventMouseButton)

func _handle_movement_input(event: InputEventMouseButton) -> void:
	if !event.pressed:
		return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	if MouseManager.has_target():
		var target: Node2D = MouseManager.get_target()
		var interactable_component: InteractableComponent = target.find_child("InteractableComponent")
		if interactable_component:
			navigation_component.target_position = interactable_component.global_position
			return
	
	navigation_component.target_position = event.global_position

