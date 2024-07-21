extends CharacterBody2D

@onready var navigation_component: NavigationComponent = $NavigationComponent
@onready var interact_component: InteractComponent = $InteractComponent
@onready var carry_component: CarryComponent = $CarryComponent

enum Actions {
	Move,
	Interact,
	Pickup,
}

var current_action: Actions = Actions.Move

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	_handle_action(event as InputEventMouseButton)

func _handle_action(event: InputEventMouseButton) -> void:
	if !event.pressed:
		return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	if MouseManager.has_target():
		var target: Node2D = MouseManager.get_target()
		var interactable_component: InteractableComponent = target.find_child("InteractableComponent")
		if interactable_component:
			current_action = Actions.Interact
			navigation_component.target_position = interactable_component.global_position
			return
		
		var pickup_component: PickUpComponent = target.find_child("PickUpComponent")
		if pickup_component:
			current_action = Actions.Pickup
			navigation_component.target_position = pickup_component.global_position
			return
	
	current_action = Actions.Move
	navigation_component.target_position = event.global_position


func _on_navigation_finished() -> void:
	match current_action:
		Actions.Move:
			return
		Actions.Interact:
			interact_component.interact()
			return
		Actions.Pickup:
			carry_component.pickup()
			return
