extends StaticBody2D

@export var potion_sold_scene: PackedScene
@export var instance_scale: float = 1.0

@onready var audio_component: AudioComponent = $AudioComponent
@onready var potion_sold_spawn_point: Node2D = $PotionSoldSpawnPoint
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var dropoff_component: DropOffComponent = $DropOffComponent

func _ready() -> void:
	var scalar := Vector2(instance_scale, instance_scale)
	if Engine.is_editor_hint():
		sprite.apply_scale(scalar)
		collision.apply_scale(scalar)
		clickable_component.apply_scale(scalar)
		dropoff_component.apply_scale(scalar)
		return
	
	sprite.apply_scale(scalar)
	collision.apply_scale(scalar)
	clickable_component.apply_scale(scalar)
	dropoff_component.apply_scale(scalar)
	
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
