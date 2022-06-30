extends KinematicBody2D

const MOTION_SPEED = 200.0 # Pixels/second.

enum Orientations {
	NORTH,
	EAST,
	SOUTH,
	WEST,
	NEUTRAL
}

var orientation
var health_bar:ProgressBar


onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var health:HealthNode = $HeatlhNode
onready var sight = $Sight/Sprite

func _ready():
	health_bar = get_tree().get_root().find_node("HealthBar", true, false)
	#warning-ignore:return_value_discarded
	health.connect("health_updated", health_bar, "update_values")	

func _physics_process(_delta):
	var motion = compute_motion()
	set_orientation_according_to(motion)
	play_animation_corresponding_to_orientation()
	#warning-ignore:return_value_discarded
	move_and_slide(motion)


func compute_motion() -> Vector2:		
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	return motion


func set_orientation_according_to(motion:Vector2):
	if motion.x == 0.0 and motion.y == 0.0:
		orientation = Orientations.NEUTRAL
		return
	if motion.y > 0.0 and motion.x == 0.0 :
		orientation = Orientations.SOUTH
		return
	if motion.y < 0.0 and motion.x == 0.0 :
		orientation = Orientations.NORTH
		return
	if motion.x > 0.0 and motion.y == 0.0 :
		orientation = Orientations.EAST
		return
	if motion.x < 0.0 and motion.y == 0.0 :
		orientation = Orientations.WEST
		return
	if motion.x > 0.0 and motion.y > 0.0 :
		orientation = Orientations.EAST
		return
	if motion.x < 0.0 and motion.y > 0.0 :
		orientation = Orientations.WEST
		return
	if motion.x > 0.0 and motion.y < 0.0 :
		orientation = Orientations.EAST
		return
	if motion.x < 0.0 and motion.y < 0.0 :
		orientation = Orientations.WEST
		return


func play_animation_corresponding_to_orientation() -> void:
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


func hurt(damage:float, crit:bool) -> void : 
	$FCTMgr.show_value(damage, crit)
	health.consume(int(damage))
