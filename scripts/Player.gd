extends KinematicBody2D

signal orientation_changed

const MOTION_SPEED = 200.0 # Pixels/second.

var orientation
var last_orientation
var health_bar:ProgressBar
var xp_bar:ProgressBar

export var critic_rate = 0.2

onready var walk_animation_manager = $WalkAnimationManager
onready var health:HealthNode = $HeatlhNode
onready var xp:XPNode = $XPNode
onready var sight = $Sight/Sprite
onready var _random = RandomNumberGenerator.new()
onready var fct_mgr = $FCTMgr
onready var Nodes = get_node("/root/Nodes")


func _ready():
	health_bar = Nodes.health_bar
	#warning-ignore:return_value_discarded
	health.connect("health_updated", health_bar, "update_values")	
	xp_bar = Nodes.xp_bar
	#warning-ignore:return_value_discarded
	xp.connect("xp_updated", xp_bar, "update_values")	


func _physics_process(_delta):
	var motion = compute_motion()
	
	orientation = walk_animation_manager.get_orientation_according_to(motion)
	if orientation != last_orientation:
		emit_signal("orientation_changed", orientation)
		last_orientation = orientation
		
	walk_animation_manager.play_animation_corresponding_to_orientation($AnimationPlayer, orientation)
	#warning-ignore:return_value_discarded
	move_and_slide(motion)


func compute_motion() -> Vector2:		
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	return motion


func gets_a_critic() -> bool:
	return _random.randf_range(0.0, 1.0) < critic_rate


func hurt(damage:float, crit:bool) -> void : 
	fct_mgr.show_value(damage, crit)
	health.consume(int(damage))
