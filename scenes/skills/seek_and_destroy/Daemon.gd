extends Area2D

signal orientation_changed

var path:Array
var motion
var orientation 
var last_orientation
var closest_enemy
var target = null
var _under_cooldown = false
var flame_thrower 
var _attacking:bool = false
var enemies_in_aggro_range = []

export var speed:float = 200.0
export var damage:float = 100.0
export var duration:float = 2.0
export var min_distance:float = 10.0
export var attack_range:float = 30.0

onready var Nodes = get_node("/root/Nodes")
onready var path_line = $PathLine
onready var walk_animation_manager = $WalkAnimationManager
onready var animation_player = $AnimationPlayer


func _ready():
	set_as_toplevel(true)
	position = Nodes.player.position
	flame_thrower = Skills.FlameThrower.instance()
	flame_thrower.apply_scale(Vector2(0.8, 0.8))
	#warning-ignore:return_value_discarded
	connect("orientation_changed", flame_thrower, "_on_orientation_changed")


func _physics_process(delta):

	if _attacking:
		return

	motion = Vector2.ZERO
	
	if not is_instance_valid(closest_enemy) or closest_enemy.is_dying():
		closest_enemy = Nodes.player.get_closest_enemy()
		return
		
	path = Nodes.navigation.get_simple_path(position, closest_enemy.position , true)
	path_line.global_position = Vector2.ZERO
	if path.size() > 0:
		motion = global_position.direction_to(path[1]).normalized() * speed * delta	
		if global_position.distance_to(path[0]) < min_distance :
			path.pop_front()
		if path_line != null :
			path_line.points = path
			
		position += motion
		_update_orientation_toward(motion)
		walk_animation_manager.play_animation_corresponding_to_orientation(animation_player, orientation)
	
	if position.distance_to(closest_enemy.global_position) <= attack_range:
		attack_mode()


func attack_mode()-> void:
	_attacking = true
	add_child(flame_thrower)
	yield(get_tree().create_timer(duration), "timeout")
	_attacking = false
	remove_child(flame_thrower)


func _update_orientation_toward(this_position:Vector2) -> void:
	orientation = walk_animation_manager.get_orientation_according_to(this_position)
	if orientation != last_orientation:
		emit_signal("orientation_changed", orientation)
		last_orientation = orientation


func is_in_attack_range() -> bool:
	return position.distance_to(closest_enemy.position) <= attack_range


func _cooldown() -> void:
	_under_cooldown = true
	yield(get_tree().create_timer(2.0), "timeout")
	_under_cooldown = false


func is_attacking() -> bool:
	return _attacking


