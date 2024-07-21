extends Node2D
class_name AudioComponent

@export var audio_clips: Array[AudioStream]

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var _rng := RandomNumberGenerator.new()

func _ready() -> void:
	assert(audio_clips.size() > 0)

func play() -> void:
	audio_player.stream = audio_clips[_rng.randi_range(0, audio_clips.size() - 1)]
	audio_player.play()
