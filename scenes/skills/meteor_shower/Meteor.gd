extends Node2D

var player_position:Vector2

onready var player = get_tree().get_root().find_node("Player", true, false)

func _ready():
	set_as_toplevel(true)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	position = player.position - Vector2 (rng.randf_range(-30.0, 30.0), 400.0)
	
