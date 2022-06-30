extends Node2D

var Shuriken = preload("res://scenes/Shuriken.tscn")
var player


func _ready():
	player = get_tree().get_root().find_node("Player", true, false)


func _on_Timer_timeout():
	var shuriken = Shuriken.instance()
	shuriken.position = player.sight.global_position
	shuriken.motion = (player.sight.global_position - player.global_position).normalized()
	get_tree().get_root().add_child(shuriken)

		
