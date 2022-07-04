extends Line2D

export var  max_points = 30

func _ready():
	set_as_toplevel(true)
	

func _physics_process(delta):
	add_point(get_parent().global_position)
	if points.size() > max_points :
		remove_point(0)
