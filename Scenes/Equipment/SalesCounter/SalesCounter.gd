extends StaticBody2D

@export var potion_sold_scene: PackedScene
@export var instance_scale: float = 1.0

@onready var audio_component: AudioComponent = $AudioComponent
@onready var potion_sold_spawn_point: Node2D = $PotionSoldSpawnPoint
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if Engine.is_editor_hint():
		sprite.apply_scale(Vector2(instance_scale, instance_scale))
		return
	sprite.apply_scale(Vector2(instance_scale, instance_scale))
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return

func _on_drop_off_potion_event(potion: PotionResource) -> void:
	audio_component.play()
	GameStateManager.sell_potion(potion)
	var potion_sold: PotionSold = potion_sold_scene.instantiate()
	potion_sold.position = potion_sold_spawn_point.position
	add_child(potion_sold)
	potion_sold.play(potion.value)
