extends KinematicBody2D

var player
var _under_cool_down:bool = false
var _random

export var speed = 100
export var damage = 5.0
export var cool_down_duration = 1.0

onready var health_bar:ProgressBar = $HealthBar
onready var health:HealthNode = $HeatlhNode


func _ready():
	#warning-ignore:return_value_discarded
	health.connect("health_updated", health_bar, "update_values")	
	health.connect("has_died", self, "dies")
	player = get_tree().get_root().find_node("Player", true, false)
	_random = RandomNumberGenerator.new()
#	connect("has_hit_enemy", self, "_on_hit")


func _physics_process(delta):
	var collision = move_and_collide(position.direction_to(player.position).normalized() * speed * delta)
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
	

func hurt(damage:float, crit:bool) -> void : 
	health.consume(int(damage))


func dies() -> void:
	call_deferred("queue_free")

#func _on_hit(enemy:Node2D, damage) -> void:
#	print("Gets a hit signal")
#	if enemy == self :
#		print("Touché ! " + str(damage))
#		health -= damage
#		if health <= 0 :
#			print("Mort !")
#			call_deferred("queue_free")
