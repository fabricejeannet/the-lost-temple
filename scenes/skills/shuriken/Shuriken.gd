extends KinematicBody2D

var motion:Vector2
export var speed:float = 100.0
export var damage = 10

func _physics_process(_delta):
	rotate(deg2rad(10.0))
	#warning-ignore:return_value_discarded
	move_and_slide(motion * speed)

