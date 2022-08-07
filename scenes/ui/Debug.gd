extends Control

var SeekAndDestroySkill = preload("res://scenes/skills/seek_and_destroy/SeekAndDestroySkill.tscn")
var seek_and_destroy_skill
var DeathWhirlpool = preload("res://scenes/skills/death_whirlpool/DeathWhirlpoolSkill.tscn")
var death_whirlpool_skill
var ShurikenSkill = preload("res://scenes/skills/shuriken/ShurikenSkill.tscn")
var shuriken_skill


onready var Nodes = get_node("/root/Nodes")

func _ready():
#	OS.set_window_maximized(true)
	seek_and_destroy_skill = SeekAndDestroySkill.instance()
	death_whirlpool_skill = DeathWhirlpool.instance()
	shuriken_skill = ShurikenSkill.instance()
	
func _on_CB_SeekAndDestroy_toggled(button_pressed):
	if button_pressed:
		Nodes.player.add_child(seek_and_destroy_skill)
	else:
		Nodes.player.remove_child(seek_and_destroy_skill)
		seek_and_destroy_skill = SeekAndDestroySkill.instance()

func _on_CB_DeathWhirlpool_toggled(button_pressed):
	if button_pressed:
		Nodes.player.add_child(death_whirlpool_skill)
	else:
		Nodes.player.remove_child(death_whirlpool_skill)
		death_whirlpool_skill = DeathWhirlpool.instance()


func _on_CB_Shuriken_toggled(button_pressed):
	if button_pressed:
		Nodes.player.add_child(shuriken_skill)
	else:
		Nodes.player.remove_child(shuriken_skill)
		shuriken_skill = ShurikenSkill.instance()
