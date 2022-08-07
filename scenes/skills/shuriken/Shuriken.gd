extends KinematicBody2D

var motion:Vector2
export var speed:float = 100.0
export var damage = 10

func _physics_process(delta):
	rotate(deg2rad(10.0))
	var collision = 	move_and_collide(motion * speed  * delta)
	if collision:
		var collider = collision.collider
		if collider.is_in_group("enemy"):
			collider.hurt(damage)
		
		call_deferred("queue_free")	
	
