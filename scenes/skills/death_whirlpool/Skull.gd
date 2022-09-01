extends Area2D

var counter = 0.0
var max_points:int
var angle

export var speed = 200
export var radius = 100.0
export var damage = 100

func _physics_process(delta):
	counter += delta
	position = Vector2 (cos(counter * speed * delta + angle) * radius,  sin(counter * speed * delta + angle) * radius) 


func _on_DeathWhirlpool_body_entered(body):
	if body.is_in_group("enemy"):
		body.hurt(damage)


func increase_damage(rate:float) -> void:
	damage += damage * rate
