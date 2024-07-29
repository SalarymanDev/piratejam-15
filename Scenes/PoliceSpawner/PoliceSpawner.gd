extends Node2D

@export var police_officer_scene: PackedScene

@onready var spawn_point: Node2D = $SpawnPoint
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var blue_light: PointLight2D = $BluePointLight2D
@onready var red_light: PointLight2D = $RedPointLight2D

func _ready() -> void:
	GameStateManager.police_inbound_event.connect(_on_police_inbound_event)
	_enable_lights(false)

func _on_police_inbound_event() -> void:
	audio_player.play()
	animation_player.set_current_animation("PoliceLights")
	_enable_lights(true)
	animation_player.play()

func _on_audio_finished() -> void:
	animation_player.stop()
	_enable_lights(false)
	var officer: CharacterBody2D = police_officer_scene.instantiate()
	officer.global_position = spawn_point.global_position
	get_tree().root.add_child.call_deferred(officer)

func _enable_lights(enabled: bool) -> void:
	blue_light.visible = enabled
	red_light.visible = enabled
