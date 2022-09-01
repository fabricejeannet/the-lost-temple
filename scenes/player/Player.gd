extends KinematicBody2D

signal orientation_changed

const MOTION_SPEED = 200.0 # Pixels/second.

var orientation
var last_orientation
var health_bar:ProgressBar
var xp_bar:ProgressBar
var enemies_in_pet_defense_area = []
var closest_enemy:Enemy = null

export var critic_rate = 0.2

onready var walk_animation_manager = $WalkAnimationManager
onready var health:HealthNode = $HeatlhNode
onready var xp:XPNode = $XPNode
onready var sight = $Sight/Sprite
onready var _random = RandomNumberGenerator.new()
onready var fct_mgr = $FCTMgr
onready var Nodes = get_node("/root/Nodes")
onready var interaction_area = $InteractionArea


func _ready():
	health_bar = Nodes.health_bar
	#warning-ignore:return_value_discarded
	health.connect("health_updated", health_bar, "update_values")	
	xp_bar = Nodes.xp_bar
	#warning-ignore:return_value_discarded
	xp.connect("xp_updated", xp_bar, "update_values")	


func _physics_process(_delta):
	var motion = compute_motion()
	orientation = walk_animation_manager.get_orientation_according_to(motion)
	if orientation != last_orientation:
		emit_signal("orientation_changed", orientation)
		last_orientation = orientation
		
	walk_animation_manager.play_animation_corresponding_to_orientation($AnimationPlayer, orientation)
	#warning-ignore:return_value_discarded
	move_and_slide(motion)


func compute_motion() -> Vector2:		
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	return motion


func gets_a_critic() -> bool:
	return _random.randf_range(0.0, 1.0) < critic_rate


func hurt(damage:float, crit:bool) -> void : 
	fct_mgr.show_value(damage, crit)
	health.consume(int(damage))


func _on_InteractionArea_entered(area):
	if area is Gem:
		area.fly_toward_player()




func _on_PetDefense_body_entered(body):
	if body is Enemy:
		enemies_in_pet_defense_area.append(body)


func _on_PetDefense_body_exited(body):
	if body is Enemy : #and not body.is_dying():
		enemies_in_pet_defense_area.erase(body)


func get_closest_enemy() -> Enemy:
	if enemies_in_pet_defense_area.size() > 0:
		closest_enemy = enemies_in_pet_defense_area[0]
		var closest_enemy_position = closest_enemy.position.distance_to(position)
		for enemy in enemies_in_pet_defense_area:
			var enemy_distance_to_player = enemy.position.distance_to(position)
			if enemy_distance_to_player < closest_enemy_position:
				closest_enemy = enemy
				closest_enemy_position = enemy_distance_to_player
				update()
		return closest_enemy
	return null



func _draw():
	if closest_enemy != null :
		draw_arc(closest_enemy.position, 20, deg2rad(0.0), deg2rad(360.0), 50, Color.red, 1.0)	

