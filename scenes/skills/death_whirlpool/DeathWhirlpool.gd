extends Skill

var Skull = preload("res://scenes/skills/death_whirlpool/Skull.tscn")
var skulls = []
var max_points:int = 25
var angle = 0.0

export (int, 1,10) var skull_count = 1
export var speed = 120
export var radius = 100.0
export var damage = 20
export var bump_distance = 20

func _ready():
	improvements = [
		{
			"increase_speed":0.1,
			"increase_skull_count":1,
			"increase_radius" : 0.2,
			"increase_bump_distance" : 0.1,
			"increase_damage" : 0.2,
		},
		{
			"increase_speed":0.1,
			"increase_skull_count":1,
			"increase_radius" : 0.2,		
			"increase_bump_distance" : 0.1,
			"increase_damage" : 0.2,
		},
		{
			"increase_speed":0.1,
			"increase_skull_count":1,
			"increase_radius" : 0.2,
			"increase_bump_distance" : 0.1,
			"increase_damage" : 0.2,
		},
		{
			"increase_speed":0.1,
			"increase_skull_count":1,
			"increase_radius" : 0.2,
			"increase_bump_distance" : 0.1,
			"increase_damage" : 0.2,
		},
	]
	create_skulls()


func perform_skill():
	for skull in skulls:
		add_child(skull)


func cancel_skill():
	for skull in skulls:
		remove_child(skull)


func create_skulls() -> void:
	angle = 0.0
	for count in skull_count:
		var skull =  Skull.instance()
		skull.angle = angle
		skull.speed = speed
		skull.radius = radius
		skull.damage = damage
		skull.bump_distance = bump_distance

		if skull_count > 1 :
			skull.max_points = max_points * (1 - 1 / skull_count)
		else :
			skull.max_points = max_points * 2
		
		skulls.append(skull)
		angle += 2.0 * PI / skull_count


func level_up() :
	if max_level_not_reached() :
		Logger.debug("-> Death Whirlpool")
		.level_up()
		update_skill()

func increase_speed(rate:float) -> void:
	speed += speed * rate
	Logger.debug("\tspeed is now " + str(speed))


func increase_skull_count(count:int) -> void:
	skull_count += count
	Logger.debug("\tskull count is now " + str(skull_count))


func increase_radius(rate:float) -> void:
	radius += radius * rate
	Logger.debug("\tradius is now " + str(radius))


func increase_bump_distance(rate:float) -> void:
	bump_distance += bump_distance * rate
	Logger.debug("\tbump distance is now " + str(bump_distance))


func increase_damage(rate:float) -> void:
	damage += damage * rate
	Logger.debug("\tdamage is now " + str(damage))


func update_skill() -> void:
	for skull in skulls :
		skull.free()
	skulls.clear()
	create_skulls()
	perform_skill()
