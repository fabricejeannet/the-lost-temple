extends Node2D

enum Orientations {
	NORTH,
	EAST,
	SOUTH,
	WEST,
	NEUTRAL
}

#onready var animation_player:AnimationPlayer = get_parent().get_node("AnimationPlayer")


func get_orientation_according_to(motion:Vector2):
	if motion.x == 0.0 and motion.y == 0.0:
		return  Orientations.NEUTRAL
		
	if motion.y > 0.0 and motion.x == 0.0 :
		return Orientations.SOUTH
		
	if motion.y < 0.0 and motion.x == 0.0 :
		return Orientations.NORTH
	
	if motion.x > 0.0 and motion.y == 0.0 :
		return Orientations.EAST
		
	if motion.x < 0.0 and motion.y == 0.0 :
		return Orientations.WEST
		
	if motion.x > 0.0 and motion.y > 0.0 :
		return Orientations.EAST
		
	if motion.x < 0.0 and motion.y > 0.0 :
		return Orientations.WEST
		
	if motion.x > 0.0 and motion.y < 0.0 :
		return Orientations.EAST
		
	if motion.x < 0.0 and motion.y < 0.0 :
		return Orientations.WEST



func play_animation_corresponding_to_orientation(animation_player, orientation) -> void:
	match orientation:
		Orientations.EAST:
			animation_player.play("walk_right")
		Orientations.WEST:
			animation_player.play("walk_left")
		Orientations.NORTH:
			animation_player.play("walk_up")
		Orientations.SOUTH:
			animation_player.play("walk_down")
		Orientations.NEUTRAL:
			animation_player.play("idle")	
