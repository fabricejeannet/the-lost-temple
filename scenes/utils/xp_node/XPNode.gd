extends Node2D

class_name XPNode

signal xp_updated
signal level_up

var current_level:int = 0
var current_xp:int = 0

export var coeff:float = 1.5
export var max_xp:int = 10


func get_max_xp() -> int :
	return max_xp


func set_max_xp(_max_xp:int) :
	max_xp = _max_xp
	Logger.debug("Max XP is now " + str(max_xp))
	emit_signal("xp_updated", max_xp, current_xp)


func increase(value:int) -> void:
	_set_current_xp(current_xp + value)
	Logger.fine("XP increased by +" + str(value))
	if current_xp >= max_xp:
		level_up()


func _set_current_xp(value:int) -> void:
	current_xp = value
	emit_signal("xp_updated", max_xp, current_xp)


func get_current_level() -> int:
	return current_level


func level_up() -> void:
	Logger.debug("Level UP ! Current lvl is " + str(current_level))
	set_max_xp(int(max_xp * (current_level + coeff)))
	_set_current_xp(0)
	current_level += 1
	Logger.debug("Current lvl is " + str(current_level))
	emit_signal("level_up")


