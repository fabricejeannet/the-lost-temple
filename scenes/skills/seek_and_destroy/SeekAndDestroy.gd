extends Area2D

var navigation:Navigation2D
var player
var world
var path:Array
var motion
var orientation 
var closest_enemy
var _in_attack_range:bool = false
var target = null

export var speed:float = 200.0
export var damage:float = 100.0
export var duration:float = 3.0
export var min_distance:float = 10.0
export var attack_range:float = 30.0

onready var Nodes = get_node("/root/Nodes")
onready var path_line = $PathLine
onready var life_timer = $LifeTimer
onready var walk_animation_manager = $WalkAnimationManager
onready var animation_player = $AnimationPlayer


func _ready():
	set_as_toplevel(true)
	world = Nodes.world
	player =  Nodes.player
	navigation = Nodes.navigation
	life_timer.wait_time = duration
	life_timer.start()
	position = player.position


func _physics_process(delta):

	motion = Vector2.ZERO
	
	if not is_instance_valid(closest_enemy) or closest_enemy.is_dying():
		closest_enemy = world.get_closest_enemy_to(player.global_position)
		return
		
	path = navigation.get_simple_path(global_position, closest_enemy.global_position, true)
	path_line.global_position = Vector2.ZERO
	if path.size() > 0:
		motion = global_position.direction_to(path[1]).normalized() * speed * delta	
		
		if global_position. distance_to(path[0]) < min_distance :
			path.pop_front()
	
		if path_line != null :
			path_line.points = path
			
		position += motion

	

	orientation = walk_animation_manager.get_orientation_according_to(motion)
	walk_animation_manager.play_animation_corresponding_to_orientation(animation_player, orientation)
	


func _on_SeekAndDestroy_body_entered(body):
	if body.is_in_group("enemy"):
		target = body
		target.hurt(damage)


func _on_SeekAndDestroy_body_exited(body):
	if body == target:
		target = null



func is_in_attack_range() -> bool:
	return closest_enemy <= attack_range


func _on_Timer_timeout():
	call_deferred("queue_free")


