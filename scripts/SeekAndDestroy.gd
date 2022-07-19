extends KinematicBody2D

var navigation:Navigation2D

var player
var world
var path:Array
var motion


export var speed:float = 10.0

onready var path_line = $PathLine

func _ready():
	world = get_tree().get_root().find_node("World", true, false)
	player = get_tree().get_root().find_node("Player", true, false)
	navigation = get_tree().get_root().find_node("Navigation2D", true, false)
	set_as_toplevel(true)

func _physics_process(delta):
	path_line.global_position = Vector2.ZERO
	
	var closest_enemy  = world.get_closest_enemy_to(global_position)
	
	if closest_enemy == null:
		return
		
	path = navigation.get_simple_path(global_position, closest_enemy.global_position, false)
	
	if path.size() > 0:
		motion = global_position.direction_to(path[-1]) * speed * delta
	
		if global_position == path[0]:
			path.pop_front()
	
		if path_line != null :
			path_line.points = path
			
#		move_and_collide(motion)
