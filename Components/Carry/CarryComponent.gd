extends Area2D
class_name CarryComponent

@onready var sprite: Sprite2D = $Sprite2D

var _current_item: IngredientResource
var _pickup_in_range: PickUpComponent

func pickup() -> void:
	if !_pickup_in_range:
		return
	if _current_item:
		_current_item = _pickup_in_range.swap(_current_item)
		_update_sprite()
		return
	_current_item = _pickup_in_range.pickup()
	_update_sprite()
	

func drop() -> void:
	pass

func _update_sprite() -> void:
	if _current_item.texture:
		sprite.texture = _current_item.texture

func _on_area_entered(area: Area2D) -> void:
	_pickup_in_range = area

func _on_area_exited(_area: Area2D) -> void:
	_pickup_in_range = null
