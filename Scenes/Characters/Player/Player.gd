extends CharacterBody2D

@onready var navigation_component: NavigationComponent = $NavigationComponent
@onready var carry_component: CarryComponent = $CarryComponent

enum Actions {
	Move,
	Pickup,
	DropOff,
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
		
		var dropoff_component: DropOffComponent = target.find_child("DropOffComponent")
		if dropoff_component and !dropoff_component.disabled:
			current_action = Actions.DropOff
			navigation_component.target_position = dropoff_component.global_position
			return
		
		var pickup_component: PickUpComponent = target.find_child("PickUpComponent")
		if pickup_component and !pickup_component.disabled:
			current_action = Actions.Pickup
			navigation_component.target_position = pickup_component.global_position
			return
	
	current_action = Actions.Move
	navigation_component.target_position = event.global_position


func _on_navigation_finished() -> void:
	match current_action:
		Actions.Move:
			return
		Actions.DropOff:
			carry_component.dropoff()
			return
		Actions.Pickup:
			carry_component.pickup()
			return
