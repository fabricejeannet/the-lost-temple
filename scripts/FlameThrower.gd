extends Area2D


export var damage =  70.0

func _on_FlameThrower_body_entered(body):
	if body.is_in_group("enemy"):
		body.hurt(damage)

