extends Node

var player
var navigation 
var world 

func _ready():
	player = get_tree().get_root().find_node("Player", true, false)
	navigation = get_tree().get_root().find_node("Navigation2D", true, false)
	world = get_tree().get_root().find_node("World", true, false)
