extends TileMap

var StoneCat = preload("res://scenes/StoneCat.tscn")
var Kabuto = preload("res://scenes/Kabuto.tscn")
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
		add_child(enemy)
		enemies.append(enemy)


func _get_random_position() -> Vector2:
	random.randomize()
	var xpos = random.randf_range(0, get_viewport().size.x)
	var ypos = random.randf_range(0, get_viewport().size.y)
	return Vector2(xpos, ypos)


