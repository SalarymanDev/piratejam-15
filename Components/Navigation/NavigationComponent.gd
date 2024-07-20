extends NavigationAgent2D
class_name NavigationComponent

@export var character: CharacterBody2D
@export var speed: float

signal navigation_completed

var _previous_navigation_finished: bool = false

func _ready() -> void:
	call_deferred("_setup")

func _setup() -> void:
	await get_tree().physics_frame

func _physics_process(_delta: float) -> void:
	if is_navigation_finished():
		if !_previous_navigation_finished:
			emit_signal(navigation_completed.get_name())
		return
	
	_previous_navigation_finished = false
	var current_position: Vector2 = character.global_position
	var next_path_position: Vector2 = get_next_path_position()
	var direction: Vector2 = current_position.direction_to(next_path_position)
	character.velocity = direction * speed
	character.move_and_slide()
