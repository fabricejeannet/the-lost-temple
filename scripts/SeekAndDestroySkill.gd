extends Node2D

var SeekAndDestroy = preload("res://scenes/skills/SeekAndDestroy.tscn")

func _ready():
	var instance = SeekAndDestroy.instance()
	add_child(instance)

func _on_Timer_timeout():
	var instance = SeekAndDestroy.instance()
	add_child(instance)
