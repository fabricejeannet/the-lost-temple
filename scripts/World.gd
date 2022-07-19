extends Node2D

var StoneCat = preload("res://scenes/enemies/StoneCat.tscn")
var Kabuto = preload("res://scenes/enemies/Kabuto.tscn")
var Shuriken = preload("res://scenes/skills/Shuriken.tscn")
var enemies = []
var random

export var max_enemies:int = 100

func _ready():
	random = RandomNumberGenerator.new()

func _on_StoneCatTimer_timeout():
	var stone_cat = StoneCat.instance()
	stone_cat.position = _get_random_position()
	_add_enemy(stone_cat)


func _on_KabutoTimer_timeout():
	var kabuto = Kabuto.instance()
	kabuto.position = _get_random_position()
	_add_enemy(kabuto)




func _add_enemy(enemy:Node2D) -> void:
	if enemies.size() < max_enemies:
		$YSort.add_child(enemy)
		enemies.append(enemy)
		enemy.connect("enemy_is_dead", self, "_on_enemy_death")


func _get_random_position() -> Vector2:
	random.randomize()	
	var xpos = random.randf_range(0, get_viewport().size.x)
	
	var ypos
	var rnd_top_or_bottom = random.randi_range(0,1)
	if rnd_top_or_bottom == 0:
		ypos =  get_viewport().size.y
	else :
		ypos = 0
		
	return Vector2(xpos, ypos)


func _on_enemy_death(enemy):
	print("One enemy is dead !")
	enemies.erase(enemy)


func get_closest_enemy_to(this_position:Vector2) -> Node2D:
	if enemies.size() > 0:
		var closest_enemy = enemies[0]
		for enemy in enemies:
			if enemy.position.distance_to(this_position) < closest_enemy.position.distance_to(this_position):
				closest_enemy = enemy
		return closest_enemy
	return null

