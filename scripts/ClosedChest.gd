extends Area2D

onready var Nodes = get_node("/root/Nodes")


func _on_ClosedChest_body_entered(body):
	if body == Nodes.player:
		$Sprite.frame = 8
		print("coffre touché")
