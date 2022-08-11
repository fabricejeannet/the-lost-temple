extends Node2D

const StoneCat = preload("res://scenes/enemies/StoneCat.tscn")

var active_skills = []
var living_enemies:int = 0
var dead_enemies:int = 0

export var max_enemies = 10
export var min_distance_from_enemy:int = 100

onready var Nodes = get_node("/root/Nodes")
onready var Skills = get_node("/root/Skills")
onready var kill_count_label = $Hud/Control/VBoxContainer/LabelKillCount

func _ready():
	Logger.set_logger_level(Logger.LOG_LEVEL_ALL)
	Nodes.player.xp.connect("level_up", self, "_on_level_up")
	add_skill(Skills.DeathWhirlpool.instance())
#	add_skill(Skills.dragon_breath)

func add_skill(skill:Node2D) -> void:
	Nodes.player.call_deferred("add_child", skill)
	var icon = TextureRect.new()
	icon.texture = skill.icon
	Nodes.buff_container.add_child(icon)
	active_skills.append(skill)


func increase_damage_for_all_active_skills(rate:float) -> void :
	for skill in active_skills:
		if skill.has_method("increase_damage"):
			skill.increase_damage(rate)


func _on_StoneCatTimer_timeout():
	var stone_cat = StoneCat.instance()
	stone_cat.position = Nodes.player.position + _get_random_position_around_player()
	add_enemy(stone_cat)


func add_enemy(enemy) -> void:
	if living_enemies <= max_enemies:
		add_child(enemy)
		enemy.connect("enemy_is_dead", self, "_on_enemy_death")
		living_enemies +=1


func _on_enemy_death(_enemy) -> void:
	living_enemies -= 1
	dead_enemies += 1
	kill_count_label.text = str(dead_enemies) + " killed"


func _get_random_position_around_player() -> Vector2:
	return Vector2(min_distance_from_enemy, 0.0).rotated(rand_range(0.0, 2.0 * PI))

func _on_level_up() -> void:
	pass
