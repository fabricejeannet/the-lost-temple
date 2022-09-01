extends Area2D

class_name Gem

var _was_reached:bool = false

export var xp:int = 1
export var speed:int = 250
export var min_distance:int = 10

onready var Nodes = get_node("/root/Nodes")

func fly_toward_player() -> void :
	_was_reached = true


func _physics_process(delta):
	if _was_reached:
		position += position.direction_to(Nodes.player.position).normalized() * Nodes.player.MOTION_SPEED * 1.33 * delta
		if position.distance_to(Nodes.player.position) < min_distance:
			visible = false
			Nodes.player.xp.increase(xp)
			call_deferred("free")
