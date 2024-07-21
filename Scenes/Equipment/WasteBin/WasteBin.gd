extends StaticBody2D

@onready var audio_component: AudioComponent = $AudioComponent


func _on_drop_off_event(_item: ItemResource) -> void:
	audio_component.play()
