extends TileMap

onready var Nodes = get_node("/root/Nodes")
var ground
var obstacles

func _ready():
	ground = Nodes.ground
	obstacles = Nodes.obstacles
	var level_cells = ground.get_used_cells_by_id(0) #if tile id 0 
	var obstacles_cells = obstacles.get_used_cells()
	for i in obstacles_cells:
		level_cells.erase(i)
	for i in level_cells:
		set_cellv(i,0)
	
	update_dirty_quadrants()


