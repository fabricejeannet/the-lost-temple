extends Node2D

class_name XPNode

signal xp_updated
signal level_up


export var max_xp:int

var current_xp:int = 0

func get_max_xp() -> int :
	return max_xp


func set_max_xp(max_health:int) :
	max_xp = max_health
	print("Max xp points is now " + str(max_xp))
	emit_signal("xp_updated", max_xp, current_xp)


func increase(value:int) -> void:
	_set_current_xp(current_xp + value)
	if current_xp >= max_xp:
		emit_signal("level_up")


func consume(value:int) -> void:
	_set_current_xp(current_xp - value)
	if current_xp <= 0:
		emit_signal("has_died")


func _set_current_xp(value:int) -> void:
	current_xp = value
	emit_signal("xp_updated", max_xp, current_xp)



