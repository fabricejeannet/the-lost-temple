extends Node2D

var player
var DeathWhirlpool = preload("res://scenes/skills/DeathWhirlpool.tscn")
var death_whirlpool

func _ready():
	player = get_tree().get_root().find_node("Player", true, false)
	death_whirlpool = DeathWhirlpool.instance()
	call_deferred("add_child", death_whirlpool)

func _on_Timer_timeout():
	death_whirlpool.queue_free()
