extends Node


const _DeathWhirlpool = preload("res://scenes/skills/death_whirlpool/DeathWhirlpool.tscn")
const _SeekAndDestroy = preload("res://scenes/skills/seek_and_destroy/SeekAndDestroy.tscn")

var death_whirlpool 
var seek_and_destroy

onready var Nodes = get_node("/root/Nodes")

func _ready():
	death_whirlpool = _DeathWhirlpool.instance()
	seek_and_destroy = _SeekAndDestroy.instance()
	
