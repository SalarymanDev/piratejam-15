extends Node2D
class_name StoreItemComponent

@export var disabled: bool = false
@export var _has_item: bool = false	
@export var _stored_item: ItemResource

@onready var item_component: ItemComponent = get_parent().find_child("ItemComponent")

##signal store_item_event(item: ItemResource)

func store(item: ItemResource) -> void:
	_stored_item = item
	item_component.item = item
	_has_item = true

func dispense() -> void:
	_has_item = !_has_item
	_stored_item = null
