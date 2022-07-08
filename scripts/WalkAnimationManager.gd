extends Node2D

onready var Constants = get_node("/root/Constants")

func get_orientation_according_to(motion:Vector2):
	if motion.x == 0.0 and motion.y == 0.0:
		return  Constants.Orientations.NEUTRAL
		
	if motion.y > 0.0 and motion.x == 0.0 :
		return Constants.Orientations.SOUTH
		
	if motion.y < 0.0 and motion.x == 0.0 :
		return Constants.Orientations.NORTH
	
	if motion.x > 0.0 and motion.y == 0.0 :
		return Constants.Orientations.EAST
		
	if motion.x < 0.0 and motion.y == 0.0 :
		return Constants.Orientations.WEST
		
	if motion.x > 0.0 and motion.y > 0.0 :
		return Constants.Orientations.SOUTH_EAST
		
	if motion.x < 0.0 and motion.y > 0.0 :
		return Constants.Orientations.SOUTH_WEST
		
	if motion.x > 0.0 and motion.y < 0.0 :
		return Constants.Orientations.NORTH_EAST
		
	if motion.x < 0.0 and motion.y < 0.0 :
		return Constants.Orientations.NORTH_WEST



func play_animation_corresponding_to_orientation(animation_player, orientation) -> void:
	
	if animation_player == null:
		return
	
	match orientation:
		Constants.Orientations.EAST:
			animation_player.play("walk_right")
		Constants.Orientations.WEST:
			animation_player.play("walk_left")
		Constants.Orientations.NORTH:
			animation_player.play("walk_up")
		Constants.Orientations.SOUTH:
			animation_player.play("walk_down")
		Constants.Orientations.NEUTRAL:
			animation_player.play("idle")	
		Constants.Orientations.NORTH_EAST:
			animation_player.play("walk_right")
		Constants.Orientations.SOUTH_EAST:
			animation_player.play("walk_right")
		Constants.Orientations.NORTH_WEST:
			animation_player.play("walk_left")
		Constants.Orientations.SOUTH_WEST:
			animation_player.play("walk_left")
