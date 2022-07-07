extends Area2D


export var damage =  70.0

func _on_FlameThrower_area_entered(area):
	if area.is_in_group("enemy"):
		area.hurt(damage)

