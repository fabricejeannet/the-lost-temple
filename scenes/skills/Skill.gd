extends Node

class_name Skill

var level:int = 0

export var icon:Texture
export var duration:float = 6.0
export var cooldown:float = 4.0


func get_level() -> int:
	return level


func level_up() -> void:
	level += 1


func _ready():
	_cooldown()


func _start() -> void:
	perform_skill()
	yield(get_tree().create_timer(duration), "timeout")
	cancel_skill()
	_cooldown()


func _cooldown() -> void:
	yield(get_tree().create_timer(cooldown), "timeout")
	_start()


func perform_skill():
	pass


func cancel_skill():
	pass
