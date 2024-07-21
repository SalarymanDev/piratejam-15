extends Node2D

@export var item: ItemResource

@onready var item_component: ItemComponent = $ItemComponent
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	item_component.item = item
	if item.image:
		sprite.texture = item.image

func update_item(new_item: ItemResource) -> void:
	item_component.item = new_item
	if item.image:
		sprite.texture = item.image


func _on_picked_up_event() -> void:
	call_deferred("queue_free")


func _on_item_swapped_event(new_item: ItemResource) -> void:
	update_item(new_item)
