extends Node2D
class_name FootstepsComponent

@export var character: CharacterBody2D
@export var audio_clips: Array[AudioStream] 

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var _rng := RandomNumberGenerator.new()
var _is_moving := false

func _ready() -> void:
	assert(audio_clips.size() > 0)
	_rng.randomize()

func _play() -> void:
	audio_player.stream = audio_clips[_rng.randi_range(0, audio_clips.size() - 1)]
	audio_player.play()

func _physics_process(_delta: float) -> void:
	var previous_is_moving := _is_moving
	_is_moving = !character.velocity.is_equal_approx(Vector2.ZERO)
	if previous_is_moving == _is_moving:
		return

	if _is_moving:
		_play()
	else:
		audio_player.stop()


func _on_audio_stream_player_2d_finished() -> void:
	if !_is_moving:
		return
	_play()
