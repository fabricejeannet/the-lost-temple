extends Node2D

var old_virtual_position:Vector2
var virtual_position:Vector2

onready var level = $Level

func _process(_delta):
	virtual_position = level.world_to_map(Nodes.player.position)
	if virtual_position != old_virtual_position:
		Logger.debug("Map position : " + str(virtual_position))
		old_virtual_position = virtual_position


#func set_level(_level:TileMap) -> void:
#	var 
