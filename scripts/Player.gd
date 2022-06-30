extends KinematicBody2D

const MOTION_SPEED = 200.0 # Pixels/second.



var orientation
var health_bar:ProgressBar


#onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var walk_animation_manager = $WalkAnimationManager
onready var health:HealthNode = $HeatlhNode
onready var sight = $Sight/Sprite

func _ready():
	health_bar = get_tree().get_root().find_node("HealthBar", true, false)
	#warning-ignore:return_value_discarded
	health.connect("health_updated", health_bar, "update_values")	

func _physics_process(_delta):
	var motion = compute_motion()
	orientation = walk_animation_manager.get_orientation_according_to(motion)
	walk_animation_manager.play_animation_corresponding_to_orientation(orientation)
	#warning-ignore:return_value_discarded
	move_and_slide(motion)


func compute_motion() -> Vector2:		
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	return motion




func hurt(damage:float, crit:bool) -> void : 
	$FCTMgr.show_value(damage, crit)
	health.consume(int(damage))
