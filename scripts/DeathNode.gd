extends Node2D

signal is_finished

func run() -> void:
	self.visible = true
	get_parent().get_node("Sprite").visible = false
	get_parent().get_node("HealthBar").visible = false
	$AnimationPlayer.play("die")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("is_finished")
