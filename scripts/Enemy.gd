extends KinematicBody2D

signal enemy_is_dead

var player
var _under_cool_down:bool = false
var orientation 
var motion:Vector2
var animation_player
var colliding_with_player
var _dying = false
var path:Array = []
var navigation:Navigation2D
var path_line:Line2D

export var speed = 100
export var damage = 5.0
export var cool_down_duration = 1.0

onready var health_bar:ProgressBar = $HealthBar
onready var health:HealthNode = $HeatlhNode
onready var death_node = $DeathNode
onready var random = RandomNumberGenerator.new()
onready var walk_animation_manager = $WalkAnimationManager

func _ready():
	#warning-ignore:return_value_discarded
	health.connect("health_updated", health_bar, "update_values")	
	#warning-ignore:return_value_discarded
	health.connect("has_died", self, "dies")
	
	animation_player = get_node_or_null("AnimationPlayer")
	player = get_tree().get_root().find_node("Player", true, false)
	navigation = get_tree().get_root().find_node("Navigation2D", true, false)
	path_line = get_node_or_null("PathLine")
	
	
func _physics_process(_delta):
	path_line.global_position = Vector2.ZERO
	if _dying:
		return
		
	path = navigation.get_simple_path(global_position, player.global_position, false)
	
	if path.size() > 0:
		motion = global_position.direction_to(path[1]) * speed
	
		if global_position == path[0]:
			path.pop_front()
	
		if path_line != null :
			path_line.points = path
		
#	motion =  position.direction_to(player.position).normalized()
	orientation = walk_animation_manager.get_orientation_according_to(motion)
	walk_animation_manager.play_animation_corresponding_to_orientation(animation_player, orientation)

	#warning-ignore:return_value_discarded
	move_and_slide(motion)
	
	if colliding_with_player:
		if not _under_cool_down :
			random.randomize()
			var coef = random.randf_range(0.0, 2.0)
			if coef > 1.0 :
				player.hurt(int(damage * coef), true)
			else: 
				player.hurt(damage, false)

			_start_cool_down()


func _start_cool_down() -> void:
	_under_cool_down = true
	yield(get_tree().create_timer(cool_down_duration), "timeout")
	_under_cool_down = false


func hurt(_damage:float) -> void : 
	random.randomize()
	var critic = player.gets_a_critic()
	if critic :
		var coef = random.randf_range(1.0, 2.0)
		_damage *= coef
		
	health.consume(int(_damage))
	$FCTMgr.show_value(int(_damage), critic)


func dies() -> void:
	_dying = true
	death_node.run()
	yield(death_node, "is_finished")
	emit_signal("enemy_is_dead", self)
	call_deferred("queue_free")
	

func _on_body_entered(body):
	if body == player:
		colliding_with_player = true


func _on_body_exited(body):
	if body == player:
		colliding_with_player = false

