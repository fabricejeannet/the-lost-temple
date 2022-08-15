extends KinematicBody2D

class_name Enemy

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
var _cooldown_timer:SceneTreeTimer

export var speed = 100
export var damage = 5.0
export var cool_down_duration = 1.0
export(PackedScene) var gem_type

onready var health_bar:ProgressBar = $HealthBar
onready var health:HealthNode = $HeatlhNode
onready var death_node = $DeathNode
onready var random = RandomNumberGenerator.new()
onready var walk_animation_manager = $WalkAnimationManager
onready var Nodes = get_node("/root/Nodes")
onready var Items = get_node("/root/Items")

func _ready():
	#warning-ignore:return_value_discarded
	health.connect("health_updated", health_bar, "update_values")	
	#warning-ignore:return_value_discarded
	health.connect("has_died", self, "dies")
	player = Nodes.player
	navigation = Nodes.navigation
	animation_player = get_node_or_null("AnimationPlayer")
	path_line = get_node_or_null("PathLine")
	if gem_type == null:
		gem_type = Items.PurpleGem
	
func _physics_process(_delta):
	path_line.global_position = Vector2.ZERO
	if _dying:
		return
		
	motion =  position.direction_to(player.position).normalized() * speed

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
	_cooldown_timer = get_tree().create_timer(cool_down_duration)
	yield(_cooldown_timer, "timeout")
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
	if is_instance_valid(_cooldown_timer):
		_cooldown_timer.set_time_left(0.0)
	death_node.run()
	_drop_gem()
	yield(death_node, "is_finished")
	emit_signal("enemy_is_dead", self)
	Logger.fine("Enemy is dead")
	call_deferred("queue_free")


func _drop_gem() -> void:
	var gem = gem_type.instance()
	gem.position = self.position
	Nodes.world.get_node("YSort").call_deferred("add_child", gem)
	

func _on_body_entered(body):
	if body == player:
		colliding_with_player = true


func _on_body_exited(body):
	if body == player:
		colliding_with_player = false


func is_dying() -> bool:
	return _dying
