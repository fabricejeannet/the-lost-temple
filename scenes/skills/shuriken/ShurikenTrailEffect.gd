extends Line2D

export var  max_points = 30

func _ready():
	set_as_toplevel(true)
	clear_points()

func _physics_process(_delta):
	var shuriken_position = get_parent().global_position
	add_point(shuriken_position)
	if points.size() > max_points :
		remove_point(0)
