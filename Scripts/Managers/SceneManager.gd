extends Node

const _ANIMATION_DURATION: float = 1.0
var _current_scene: Node = null
var _fadeBackdrop: ColorRect = ColorRect.new()
var _current_scene_path: String = ""

func _ready() -> void:
	var root := get_tree().root
	_current_scene = root.get_child(root.get_child_count() - 1)

func start_game() -> void:
	_current_scene_path = "res://Scenes/Levels/Main.tscn"
	_animate_fade_out(_load_new_scene)

func _add_backdrop() -> void:
	_fadeBackdrop.color = Color.BLACK
	_fadeBackdrop.color.a = 0.0
	_fadeBackdrop.set_anchors_preset(Control.PRESET_FULL_RECT)
	_fadeBackdrop.z_index = RenderingServer.CANVAS_ITEM_Z_MAX
	get_tree().root.add_child(_fadeBackdrop)

func _remove_backdrop() -> void:
	get_tree().root.remove_child(_fadeBackdrop)

func _animate_fade_out(on_complete: Callable) -> void:
	_add_backdrop()
	var tween := get_tree().create_tween().set_parallel()
	tween.tween_method(_set_backdrop_alpha, 0.0, 1.0, _ANIMATION_DURATION)
	tween.tween_method(_set_music_volume, -5.5, -40, _ANIMATION_DURATION)
	tween.chain().tween_callback(on_complete)

func _animate_fade_in() -> void:
	var tween := get_tree().create_tween().set_parallel()
	tween.tween_method(_set_backdrop_alpha, 1.0, 0.0, _ANIMATION_DURATION)
	tween.tween_method(_set_music_volume, -40, -5.5, _ANIMATION_DURATION)
	tween.chain().tween_callback(_animate_fade_in_complete)

func _set_backdrop_alpha(value: float) -> void:
	_fadeBackdrop.color.a = value

func _set_music_volume(value: float) -> void:
	pass
	#var busIndex = AudioServer.get_bus_index("Music")
	#AudioServer.set_bus_volume_db(busIndex, value)

func _load_new_scene() -> void:
	_deferred_transition_to_scene.call_deferred(_current_scene_path)

func _animate_fade_in_complete() -> void:
	_remove_backdrop()

func _deferred_transition_to_scene(path: String) -> void:
	# It is now safe to remove the current scene.
	_current_scene.free()
	# Load the new scene.
	var new_scene: PackedScene = ResourceLoader.load(path)
	# Instance the new scene.
	_current_scene = new_scene.instantiate()
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(_current_scene)
	get_tree().root.move_child(_current_scene, 0)
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = _current_scene
	_animate_fade_in()
