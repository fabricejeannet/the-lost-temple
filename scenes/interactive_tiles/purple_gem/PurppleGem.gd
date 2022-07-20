extends Area2D



export var xp:int = 25

onready var Nodes = get_node("/root/Nodes")
onready var Constants = get_node("/root/Constants")


func _on_PurpleGem_body_entered(body):
	if is_instance_valid(self) and body == Nodes.player:
		body.xp.increase(xp)
		call_deferred("queue_free")
