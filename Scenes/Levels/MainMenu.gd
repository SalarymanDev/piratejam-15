extends Control


func _on_start_button_pressed() -> void:
	SceneManager.start_game()

func _on_exit_button_pressed() -> void:
	get_tree().quit.call_deferred()
