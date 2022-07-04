extends KinematicBody2D

var player
var _under_cool_down:bool = false
var _random
var orientation 
var motion:Vector2
var walk_animation_manager

export var speed = 100
export var damage = 5.0
export var cool_down_duration = 1.0

onready var health_bar:ProgressBar = $HealthBar
onready var health:HealthNode = $HeatlhNode


func _ready():
	#warning-ignore:return_value_discarded
	health.connect("health_updated", health_bar, "update_values")	
	#warning-ignore:return_value_discarded
	health.connect("has_died", self, "dies")
	walk_animation_manager = get_node_or_null("WalkAnimationManager")
	player = get_tree().get_root().find_node("Player", true, false)
	_random = RandomNumberGenerator.new()


func _physics_process(delta):
	motion =  position.direction_to(player.position).normalized()
	if walk_animation_manager != null:
		orientation = walk_animation_manager.get_orientation_according_to(motion)
		walk_animation_manager.play_animation_corresponding_to_orientation(orientation)
	var collision = move_and_collide(motion * speed * delta)
	if collision != null and collision.collider == player :
		if not _under_cool_down :
			var coef = _random.randf_range(0.0, 2.0)
			if coef > 1.0 :
				player.hurt(int(damage * coef), true)
			else: 
				player.hurt(damage, false)
				
			_start_cool_down()


func _start_cool_down() -> void:
	_under_cool_down = true
	yield(get_tree().create_timer(cool_down_duration), "timeout")
	_under_cool_down = false


func hurt(_damage:float, _crit:bool) -> void : 
	health.consume(int(_damage))


func dies() -> void:
	call_deferred("queue_free")

