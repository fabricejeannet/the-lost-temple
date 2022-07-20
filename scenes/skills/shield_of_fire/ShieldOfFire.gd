extends Area2D

var damage = 15
onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("spin")	

func _on_ShieldOfFire_body_entered(body):
	if body.is_in_group("enemy"):
		body.hurt(damage, false)
