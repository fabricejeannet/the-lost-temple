extends Line2D

export var  max_points = 30
export(float, 0.0, 10.0, 0.1) var coeff_sinusoidal = 5.0

func _enter_tree():
	clear_points()


func _ready():
	set_as_toplevel(true)


func _physics_process(_delta):
	var skull_position = get_parent().global_position
	add_point(skull_position + Vector2(sin(skull_position.x) * coeff_sinusoidal, cos(skull_position.x) * coeff_sinusoidal))
	if points.size() > max_points :
		remove_point(0)
