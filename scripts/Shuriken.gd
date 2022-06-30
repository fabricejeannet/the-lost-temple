extends KinematicBody2D

var motion:Vector2
export var speed:float = 200.0
export var damage = 10

func _physics_process(delta):
	rotate(0.25)
	var collision = move_and_collide(motion * speed * delta)
	if collision :
		var collider = collision.collider
		if collider.is_in_group("enemy"):
			collider.hurt(damage, false)
#			emit_signal("has_hit_enemy", collision.collider, get_parent().damage)
		
		call_deferred("queue_free")
