extends Area2D

var counter = 0.0

export var speed = 2.0
export var radius = 100.0
export var damage = 100
export var icon:Texture

func _physics_process(delta):
	counter += delta
	position = Vector2 (cos(counter * speed) * radius,  sin(counter * speed) * radius)


func _on_DeathWhirlpool_body_entered(body):
	if body.is_in_group("enemy"):
		body.hurt(damage)


func increase_damage(rate:float) -> void:
	damage += damage * rate
