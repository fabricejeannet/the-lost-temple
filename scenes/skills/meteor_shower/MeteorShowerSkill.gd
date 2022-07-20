extends Node2D

var Meteor = preload("res://scenes/skills/meteor_shower/Meteor.tscn")


export var meteor_count:int = 3


func _on_Timer_timeout():
	for index in meteor_count:
		var meteor = Meteor.instance()
		add_child(meteor)
		meteor.get_node("AnimationPlayer").play("shower")
		yield(get_tree().create_timer(0.2), "timeout")

