extends Control

@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_start_button_pressed() -> void:
	audio_stream_player.play()
	SceneManager.start_game()

func _on_exit_button_pressed() -> void:
	get_tree().quit.call_deferred()
