extends Node2D


var FlameThrower = preload("res://scenes/skills/FlameThrower.tscn")

onready var Constants = get_node("/root/Constants")
onready var player = get_tree().get_root().find_node("Player", true, false)

func _ready():
	player.connect("orientation_changed", self, "_on_player_orientation_changed")

func _on_Timer_timeout():
	var flame_thrower = FlameThrower.instance()
	add_child(flame_thrower)
	yield(get_tree().create_timer(3), "timeout")
	remove_child(flame_thrower)
	
func _on_player_orientation_changed(orientation) -> void:
	match orientation:
		Constants.Orientations.NEUTRAL:
			rotation_degrees = 180.0
			position = Vector2(0.0, 30.0)
		Constants.Orientations.EAST:
			rotation_degrees = 90.0
			position = Vector2(30.0, 0.0)
		Constants.Orientations.SOUTH:
			rotation_degrees = 180.0
			position = Vector2(0.0, 30.0)
		Constants.Orientations.WEST:
			rotation_degrees = 270.0
			position = Vector2(-30.0, 0.0)
		Constants.Orientations.NORTH:
			rotation_degrees = 0.0
			position = Vector2(0.0, -30.0)
		Constants.Orientations.NORTH_EAST:
			rotation_degrees = 45.0
			position = Vector2(30.0, -30.0)
		Constants.Orientations.SOUTH_EAST:
			rotation_degrees = 135.0
			position = Vector2(30.0, 30.0)
		Constants.Orientations.NORTH_WEST:
			rotation_degrees = 315.0
			position = Vector2(-30.0, -30.0)
		Constants.Orientations.SOUTH_WEST:
			rotation_degrees = 225.0
			position = Vector2(-30.0, 30.0)

