extends Node

const Levels = preload("res://scenes/world/Levels.tscn")

var level_0

func _ready():
	var levels = Levels.instance()
	
	
