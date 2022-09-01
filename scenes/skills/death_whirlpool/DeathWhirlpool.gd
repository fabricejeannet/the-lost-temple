extends Skill

var Skull = preload("res://scenes/skills/death_whirlpool/Skull.tscn")
var skulls = []

export var max_points:int = 30
export var skull_count = 1

func perform_skill():
	var skull
	var angle = 0.0
	for count in skull_count:
		skull = Skull.instance()
		skull.angle = angle
		skull.max_points = max_points / (skull_count / 2 + 1)
		add_child(skull)
		skulls.append(skull)
		angle += 2.0 * PI / skull_count
		
func cancel_skill():
	for skull in skulls:
		remove_child(skull)


