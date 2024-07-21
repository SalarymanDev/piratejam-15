extends Area2D
class_name PickUpComponent

@export var item_component: ItemComponent
@export var is_swappable: bool = true

signal picked_up_event
signal item_swapped_event(new_item: ItemResource)

func pickup() -> ItemResource:
	emit_signal(picked_up_event.get_name())
	return item_component.item

func swap(new_item: ItemResource) -> ItemResource:
	if !is_swappable:
		return new_item
	var old_item := item_component.item
	emit_signal(item_swapped_event.get_name(), new_item)
	return old_item
