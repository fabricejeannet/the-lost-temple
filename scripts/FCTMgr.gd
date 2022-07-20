extends Node2D

enum Types {
	DAMAGES,
	HEAL,
}

var FCT = preload("res://scenes/player/FCT.tscn")
var fct 
export var travel = Vector2(0, -80)
export var duration = 2
export var spread = PI/2

func show_value(value, crit=false, color:Color=Color(1,0,0)):
	fct = FCT.instance()
	add_child(fct)
	fct.show_value(str(value), travel, duration, spread, crit, color)
