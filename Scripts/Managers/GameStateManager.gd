extends Node

signal day_started_event(current_day: int)
signal day_completed_event(revenue: int, rent: int, profit: int, money: int)
signal time_changed_event(remaining_seconds: float)
signal money_changed_event(amount: int)
signal rent_changed_event(amount: int)
signal revenue_changed_event(amount: int)
signal profit_changed_event(amount: int)

var _current_rent: int = 0
var _current_day: int = 0
var _current_money: int = 0
var _potions_sold_per_day: Dictionary = {}
var _potions_sold_today: Array[PotionResource] = []
var _timer: Timer = Timer.new()
var _level_seconds: int = 300
var _controls_enabled: bool = false

func _ready() -> void:
	_timer.one_shot = true
	get_tree().root.add_child.call_deferred(_timer)
	_timer.timeout.connect(end_day)
	emit_signal(money_changed_event.get_name(), _current_money)

func start_day() -> void:
	_timer.start(_level_seconds)
	_controls_enabled = true
	emit_signal(rent_changed_event.get_name(), _current_rent)
	emit_signal(day_started_event.get_name(), _current_day)

func end_day() -> void:
	_timer.stop()
	_controls_enabled = false
	var revenue: int = 0
	for potion_sold in _potions_sold_today:
		revenue += potion_sold.value
	var profit: int = revenue - _current_rent
	add_money(profit)
	emit_signal(day_completed_event.get_name(), revenue, _current_rent, profit, _current_money)
	_potions_sold_per_day[_current_day] = _potions_sold_today
	_potions_sold_today = []
	_current_day += 1
	_current_rent += 100

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

func _physics_process(_delta: float) -> void:
	if !_timer.is_stopped():
		emit_signal(time_changed_event.get_name(), _timer.time_left)
