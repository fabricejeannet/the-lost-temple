extends Area2D

class_name Skull

var counter = 0.0
var max_points:int
var angle
var speed
var radius
var damage
var bump_distance


func _physics_process(delta):
	counter += delta
	position = Vector2 (cos(counter * speed * delta + angle) * radius,  sin(counter * speed * delta + angle) * radius) 


func _on_DeathWhirlpool_body_entered(body):
	if body.is_in_group("enemy"):
		body.bump(bump_distance)	
		body.hurt(damage)


func increase_damage(rate:float) -> void:
	damage += damage * rate
