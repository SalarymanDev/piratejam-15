extends CharacterBody2D

@onready var navigation_component: NavigationComponent = $NavigationComponent
@onready var carry_component: CarryComponent = $CarryComponent
@onready var sprite: Sprite2D = $Sprite2D

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
	if !GameStateManager.controls_enabled():
		return
	if !event.pressed:
		return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	if MouseManager.has_target():
		var target: Node2D = MouseManager.get_target()
		
		var dropoff_component: DropOffComponent = target.find_child("DropOffComponent")
		var pickup_component: PickUpComponent = target.find_child("PickUpComponent")
		var store_component: StoreItemComponent = target.find_child("StoreItemComponent")
		
		if store_component and !store_component.disabled:
			
			if store_component._has_item:
				current_action = Actions.Pickup
				navigation_component.target_position = pickup_component.global_position
				return
			
			else:
				current_action = Actions.DropOff
				navigation_component.target_position = dropoff_component.global_position
				return
		
		if dropoff_component and !dropoff_component.disabled:
			current_action = Actions.DropOff
			navigation_component.target_position = dropoff_component.global_position
			return
		
		if pickup_component and !pickup_component.disabled:
			current_action = Actions.Pickup
			navigation_component.target_position = pickup_component.global_position
			return
	
	if event.global_position.y > 990 and event.global_position.x > 1800:
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

@onready var _original_carry_x := carry_component.position.x

func _physics_process(_delta: float) -> void:
	if velocity.x == 0:
		return
	if velocity.x > 0:
		sprite.flip_h = true
		carry_component.position.x = -_original_carry_x
	else:
		sprite.flip_h = false
		carry_component.position.x = _original_carry_x
		
