extends Area2D
class_name CarryComponent

var _current_item: IngredientResource
var _pickup_in_range: PickUpComponent

func pickup() -> void:
	if !_pickup_in_range:
		return
	if _current_item:
		_current_item = _pickup_in_range.swap(_current_item)
		return
	_current_item = _pickup_in_range.pickup()
	

func drop() -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	_pickup_in_range = area

func _on_area_exited(_area: Area2D) -> void:
	_pickup_in_range = null
