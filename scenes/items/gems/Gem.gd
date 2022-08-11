extends Area2D

class_name Gem

export var xp:int = 1

#onready var Nodes = get_node("/root/Nodes")
#onready var Constants = get_node("/root/Constants")
#

#func _on_Gem_body_entered(body):
#	if is_instance_valid(self) and body == Nodes.player:
#		Logger.fine("Player grabs gem with value +" + str(xp) + " XP")
#		body.xp.increase(xp)
#		call_deferred("queue_free")
