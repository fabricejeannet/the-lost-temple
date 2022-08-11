extends Skill

var Flame = preload("res://scenes/skills/dragon_breath/Flame.tscn")
var flame

onready var Nodes = get_node("/root/Nodes")

func _ready():
	flame = Flame.instance()
	Nodes.player.connect("orientation_changed", flame, "_on_player_orientation_changed")


func perform_skill() -> void:
	add_child(flame)


func cancel_skill() -> void:
	remove_child(flame)

