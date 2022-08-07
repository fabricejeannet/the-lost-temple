extends Node2D


var FlameThrower = preload("res://scenes/skills/flame_thrower/FlameThrower.tscn")

onready var Nodes = get_node("/root/Nodes")

func _on_Timer_timeout():
	var flame_thrower = FlameThrower.instance()
	Nodes.player.connect("orientation_changed", flame_thrower, "_on_player_orientation_changed")
	add_child(flame_thrower)
	yield(get_tree().create_timer(3), "timeout")
	remove_child(flame_thrower)
	
