extends Node2D
class_name UnlockComponent

@export var dropoff_component: DropOffComponent

var _unlocked: bool = true
var _key_item: ItemResource

signal unlocked

func _on_drop_off_component_drop_off_potion_event(potion: PotionResource) -> void:
	print("unlock component detected dropped off potion")
	if _key_item.name == potion.name:
		_unlocked = true
		unlocked.emit()

func isUnlocked() -> bool:
	return _unlocked
