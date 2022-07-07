extends Node2D


var FlameThrower = preload("res://scenes/skills/FlameThrower.tscn")

onready var walk_animation_manager = get_node("/root/WalkAnimationManager")
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
		walk_animation_manager.Orientations.EAST:
			rotation_degrees = 90.0
			position = Vector2(30.0, 0.0)
		walk_animation_manager.Orientations.SOUTH:
			rotation_degrees = 180.0
			position = Vector2(0.0, 30.0)
		walk_animation_manager.Orientations.WEST:
			rotation_degrees = 270.0
			position = Vector2(-30.0, 0.0)
		walk_animation_manager.Orientations.NORTH:
			rotation_degrees = 0.0
			position = Vector2(0.0, -30.0)
