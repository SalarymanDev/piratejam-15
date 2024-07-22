extends StaticBody2D

@export var potion_sold_scene: PackedScene

@onready var audio_component: AudioComponent = $AudioComponent
@onready var potion_sold_spawn_point: Node2D = $PotionSoldSpawnPoint

func _on_drop_off_potion_event(potion: PotionResource) -> void:
	audio_component.play()
	GameStateManager.sell_potion(potion)
	var potion_sold: PotionSold = potion_sold_scene.instantiate()
	potion_sold.position = potion_sold_spawn_point.position
	add_child(potion_sold)
	potion_sold.play(potion.value)
