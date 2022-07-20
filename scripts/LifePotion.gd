extends Area2D

export var life_points:int = 25

onready var Nodes = get_node("/root/Nodes")
onready var Constants = get_node("/root/Constants")

func _on_LifePotion_body_entered(body):
	if body == Nodes.player:
		body.health.increase(life_points)
		body.fct_mgr.show_value(life_points, true, Color(0,1,0))
		call_deferred("queue_free")
