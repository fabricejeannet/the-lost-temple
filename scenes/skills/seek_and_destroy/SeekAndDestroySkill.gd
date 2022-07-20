extends Node2D

var SeekAndDestroy = preload("res://scenes/skills/seek_and_destroy/SeekAndDestroy.tscn")
var instance

func _on_Timer_timeout():
	instance = SeekAndDestroy.instance()
	add_child(instance)
