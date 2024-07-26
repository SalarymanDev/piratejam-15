extends CharacterBody2D

@export var wander_range: float = 800
@export var max_idle_time: float = 5
@export var leave_time: float = 20

@onready var navigation_component: NavigationComponent = $NavigationComponent
@onready var audio_component: AudioComponent = $AudioComponent
@onready var idle_timer: Timer = $IdleTimer
@onready var leave_timer: Timer = $LeaveTimer
@onready var sprite: Sprite2D = $Sprite2D

@onready var _original_position: Vector2 = global_position

var _leaving: bool = false
var _rng := RandomNumberGenerator.new()
var _has_fined: bool = false

func _ready() -> void:
	_on_navigation_completed()
	leave_timer.start(leave_time)

func _on_navigation_completed() -> void:
	if _leaving:
		queue_free.call_deferred()
		return
	idle_timer.start(_rng.randf_range(0, max_idle_time))

func _on_idle_timeout() -> void:
	var target := global_position + Vector2(_rng.randf_range(-wander_range, wander_range), _rng.randf_range(-wander_range, wander_range))
	navigation_component.target_position = target

func _physics_process(_delta: float) -> void:
	if !_has_fined and !GameStateManager.get_invisible():
		GameStateManager.fine()
		_has_fined = true
		audio_component.play()
	if velocity.x == 0:
		return
	if velocity.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _on_leave_timeout() -> void:
	_leaving = true
	navigation_component.target_position = _original_position
