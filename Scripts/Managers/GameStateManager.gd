extends Node

signal day_started_event(current_day: int)
signal day_completed_event(revenue: int, rent: int, profit: int, money: int)
signal time_changed_event(remaining_seconds: float)
signal money_changed_event(amount: int)
signal rent_changed_event(amount: int)
signal revenue_changed_event(amount: int)
signal profit_changed_event(amount: int)
signal police_inbound_event
signal invisibility_potion_changed(has_potion: bool)

var _current_rent: int = 0
var _current_day: int = 0
var _current_money: int = 0
var _potions_sold_per_day: Dictionary = {}
var _potions_sold_today: Array[PotionResource] = []
var _day_timer: Timer = Timer.new()
var _invisibility_timer: Timer = Timer.new()
var _level_seconds: int = 150
var _invisibility_seconds: int = 35
var _fine_amount: int = 200
var _controls_enabled: bool = false
var _invisible: bool = false
var _police_timer: Timer = Timer.new()

var _rng := RandomNumberGenerator.new()

func _ready() -> void:
	_rng.randomize()
	_invisibility_timer.one_shot = true
	get_tree().root.add_child.call_deferred(_invisibility_timer)
	_invisibility_timer.timeout.connect(_invisibility_timeout)
	_day_timer.one_shot = true
	get_tree().root.add_child.call_deferred(_day_timer)
	_day_timer.timeout.connect(_end_day)
	_police_timer.one_shot = true
	get_tree().root.add_child.call_deferred(_police_timer)
	_police_timer.timeout.connect(_police_inbound)
	emit_signal(money_changed_event.get_name(), _current_money)

func start_day() -> void:
	_day_timer.start(_level_seconds)
	_controls_enabled = true
	emit_signal(rent_changed_event.get_name(), _current_rent)
	emit_signal(day_started_event.get_name(), _current_day)
	if _current_day >= 3:
		_police_timer.start(_rng.randf_range(40, _level_seconds - 40))

func _end_day() -> void:
	_day_timer.stop()
	_controls_enabled = false
	var revenue: int = 0
	for potion_sold in _potions_sold_today:
		revenue += potion_sold.value
	var profit: int = revenue - _current_rent
	subtract_money(_current_rent)
	emit_signal(day_completed_event.get_name(), revenue, _current_rent, profit, _current_money)
	_potions_sold_per_day[_current_day] = _potions_sold_today
	_potions_sold_today = []
	_current_day += 1
	_current_rent += 100
	emit_signal(rent_changed_event.get_name(), _current_rent)

func sell_potion(potion: PotionResource) -> void:
	add_money(potion.value)
	_potions_sold_today.append(potion)

func add_money(amount: int) -> void:
	_current_money += amount
	emit_signal(money_changed_event.get_name(), _current_money)

func subtract_money(amount: int) -> void:
	_current_money -= amount
	emit_signal(money_changed_event.get_name(), _current_money)

func get_level_seconds() -> int:
	return _level_seconds

func get_money() -> int:
	return _current_money

func get_day() -> int:
	return _current_day

func controls_enabled() -> bool:
	return _controls_enabled

func get_invisible() -> bool:
	return _invisible

func fine() -> void:
	subtract_money(_fine_amount)

func use_invisibility_potion() -> void:
	_invisible = true
	_has_invisibility_potion = false
	emit_signal(invisibility_potion_changed.get_name(), _has_invisibility_potion)
	var nodes: Array[Node] = get_tree().get_nodes_in_group("Invisibility")
	for node in nodes:
		(node as Node2D).modulate = Color(1, 1, 1, 0.25)
	_invisibility_timer.start(_invisibility_seconds)

func fill_invisibility_potion() -> void:
	_has_invisibility_potion = true
	emit_signal(invisibility_potion_changed.get_name(), _has_invisibility_potion)

var _has_invisibility_potion: bool = true
func has_invisibility_potion() -> bool:
	return _has_invisibility_potion

func _invisibility_timeout() -> void:
	_invisible = false
	var nodes: Array[Node] = get_tree().get_nodes_in_group("Invisibility")
	for node in nodes:
		(node as Node2D).modulate = Color(1, 1, 1, 1)

func _police_inbound() -> void:
	emit_signal(police_inbound_event.get_name())

func _physics_process(_delta: float) -> void:
	if !_day_timer.is_stopped():
		emit_signal(time_changed_event.get_name(), _day_timer.time_left)
