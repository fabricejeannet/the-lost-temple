extends Node2D

var player
var ShieldOfFire = preload("res://scenes/skills/shield_of_fire/ShieldOfFire.tscn")


func _ready():
	player = get_tree().get_root().find_node("Player", true, false)


func _on_Timer_timeout():
	var shield = ShieldOfFire.instance()
	player.add_child(shield)
	shield.animation_player.play("spin")
	yield(shield.animation_player, "animation_finished" )
	shield.queue_free()
