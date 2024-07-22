extends Node2D
class_name PotionSold

@export var speed: float = 10

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sold_amount_label: Label = $Node2D/Control/HBoxContainer/Label


func play(amount: int) -> void:
	sold_amount_label.text = "+%d" % amount
	animation_player.set_current_animation("PotionSold")
	animation_player.play()

func _on_animation_finished(_anim_name: StringName) -> void:
	call_deferred("queue_free")
