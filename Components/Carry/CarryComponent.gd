extends Area2D
class_name CarryComponent

@onready var sprite: Sprite2D = $Sprite2D

var _current_item: ItemResource
var _pickup_in_range: PickUpComponent
var _dropoff_in_range: DropOffComponent

func pickup() -> void:
	if !_pickup_in_range:
		return
	if _current_item:
		_current_item = _pickup_in_range.swap(_current_item)
		_update_sprite()
		return
		
	_current_item = _pickup_in_range.pickup()
	_update_sprite()

func dropoff() -> void:
	if !_dropoff_in_range:
		return
	if !_current_item:
		return
	if _dropoff_in_range.dropoff(_current_item):
		_current_item = null
		_update_sprite()

func _update_sprite() -> void:
	if !_current_item:
		sprite.texture = null
	elif _current_item.texture:
		sprite.texture = _current_item.texture

func _on_area_entered(area: Area2D) -> void:
	if area is PickUpComponent:
		_pickup_in_range = area
	elif area is DropOffComponent:
		_dropoff_in_range = area

func _on_area_exited(area: Area2D) -> void:
	if area is PickUpComponent:
		_pickup_in_range = null
	elif area is DropOffComponent:
		_dropoff_in_range = null
