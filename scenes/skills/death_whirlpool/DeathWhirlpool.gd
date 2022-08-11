extends Skill

var Skull = preload("res://scenes/skills/death_whirlpool/Skull.tscn")
var skull

func _ready():
	skull = Skull.instance()


func perform_skill():
	add_child(skull)


func cancel_skill():
	remove_child(skull)


