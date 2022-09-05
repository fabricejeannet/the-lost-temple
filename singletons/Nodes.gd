extends Node

var player
var navigation:Navigation2D
var world
var infinite_world
var health_bar:ProgressBar
var xp_bar:ProgressBar
var interactive_tiles:TileMap
var ground:TileMap
var obstacles:TileMap
var buff_container:HBoxContainer

func _ready():
	player = get_tree().get_root().find_node("Player", true, false)
	navigation = get_tree().get_root().find_node("Navigation2D", true, false)
	world = get_tree().get_root().find_node("World", true, false)
	infinite_world = get_tree().get_root().find_node("InfiniteWorld", true, false)
	health_bar = get_tree().get_root().find_node("HealthBar", true, false)
	xp_bar = get_tree().get_root().find_node("XPBar", true, false)
	interactive_tiles = get_tree().get_root().find_node("InteractiveTiles", true, false)
	ground = get_tree().get_root().find_node("Ground", true, false)
	obstacles = get_tree().get_root().find_node("LowDecorativeElements", true, false)
	buff_container = get_tree().get_root().find_node("BuffContainer", true, false)
