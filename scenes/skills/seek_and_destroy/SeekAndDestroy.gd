extends Skill

var Daemon = preload("res://scenes/skills/seek_and_destroy/Daemon.tscn")
var daemon

func _ready():
	daemon = Daemon.instance()


func perform_skill():
	add_child(daemon)


func cancel_skill():
	remove_child(daemon)

