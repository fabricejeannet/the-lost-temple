extends Node

func get_player() :
		return get_tree().get_root().find_node("Player", true, false)


func get_navigation():
		return get_tree().get_root().find_node("Navigation2D", true, false)
