extends TileMap


onready var ground = get_tree().get_root().find_node("Ground", true, false)
onready var obstacles = get_tree().get_root().find_node("LowDecorativeElements", true, false)

func _ready():
	var level_cells = ground.get_used_cells_by_id(0) #if tile id 0 
	var obstacles_cells = obstacles.get_used_cells()
	for i in obstacles_cells:
		level_cells.erase(i)
	for i in level_cells:
		set_cellv(i,0)
	
	update_dirty_quadrants()
	
	
#	print("w & h : " + str(get_used_rect().size))

