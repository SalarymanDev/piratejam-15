extends Node2D
class_name AudioComponent

@export var audio_clips: Array[AudioStream]
@export_range(-80, 24, 0.01, "dB") var volume_db: float = 0.0

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var _rng := RandomNumberGenerator.new()
var _loop: bool = false

func _ready() -> void:
	assert(audio_clips.size() > 0)
	_rng.randomize()

func play() -> void:
	if SceneManager._sfx_muted:
		return
	else:
		audio_player.stream = audio_clips[_rng.randi_range(0, audio_clips.size() - 1)]
		audio_player.set_volume_db(volume_db)
		audio_player.play()

func loop() -> void:
	_loop = true
	play()

func stop() -> void:
	audio_player.stop()

func _on_audio_finished() -> void:
	if _loop:
		play()
