extends Node2D

var tooltip_label: Label = Label.new()
var _current_target: Node2D

func _ready() -> void:
	tooltip_label.visible = true
	tooltip_label.text = "Test"
	get_tree().root.add_child.call_deferred(tooltip_label)

func set_target(new_target: Node2D) -> void:
	_current_target = new_target

func get_target() -> Node2D:
	return _current_target

func has_target() -> bool:
	return !!_current_target

func show_tooltip(show: bool) -> void:
	tooltip_label.visible = show

func update_tooltip() -> void:
	pass

func _process(_delta: float) -> void:
	tooltip_label.global_position = get_global_mouse_position() + Vector2(30, 30)
