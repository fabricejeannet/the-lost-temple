extends Area2D

export var damage = 30

var enemies_caught = []

onready var timer = $Timer


func _on_FlameThrower_area_entered(area):
	if area.get_parent().is_in_group("enemy"):
		enemies_caught.append(area.get_parent())
		if timer.is_stopped():
			timer.start(0.0)


func _on_FlameThrower_area_exited(area):
	if area.get_parent().is_in_group("enemy"):
		enemies_caught.erase(area.get_parent())
		if enemies_caught.size() < 1 :
			timer.stop()


func hurt_enemies_caught_in_flames() -> void:
	for enemy in enemies_caught:
		if is_instance_valid(enemy):
			enemy.hurt(damage)


func _on_Timer_timeout():
	hurt_enemies_caught_in_flames()


func _on_player_orientation_changed(orientation) -> void:
	match orientation:
		Constants.Orientations.NEUTRAL:
			rotation_degrees = 180.0
			position = Vector2(0.0, 20.0)
		Constants.Orientations.EAST:
			rotation_degrees = 90.0
			position = Vector2(20.0, 0.0)
		Constants.Orientations.SOUTH:
			rotation_degrees = 180.0
			position = Vector2(0.0, 20.0)
		Constants.Orientations.WEST:
			rotation_degrees = 270.0
			position = Vector2(-20.0, 0.0)
		Constants.Orientations.NORTH:
			rotation_degrees = 0.0
			position = Vector2(0.0, -20.0)
		Constants.Orientations.NORTH_EAST:
			rotation_degrees = 45.0
			position = Vector2(20.0, -20.0)
		Constants.Orientations.SOUTH_EAST:
			rotation_degrees = 135.0
			position = Vector2(20.0, 20.0)
		Constants.Orientations.NORTH_WEST:
			rotation_degrees = 315.0
			position = Vector2(-20.0, -20.0)
		Constants.Orientations.SOUTH_WEST:
			rotation_degrees = 225.0
			position = Vector2(-20.0, 20.0)








func _on_Flame_body_entered(body):
	if body.is_in_group("enemy"):
		enemies_caught.append(body)
		if timer.is_stopped():
			timer.start(0.0)





func _on_Flame_body_exited(body):
	if body.is_in_group("enemy"):
		enemies_caught.erase(body)
	if enemies_caught.size() < 1 :
		timer.stop()
