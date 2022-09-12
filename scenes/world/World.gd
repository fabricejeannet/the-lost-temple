extends TileMap

const Levels = preload("res://scenes/world/Levels.tscn")
var selected_level
var old_position_on_map:Vector2
var position_on_map:Vector2

var virtual_x
var virtual_y
var nb_x = 0
var nb_y = 0
var width 
var height
var cell_positions

func _ready():
	selected_level = Levels.instance().get_node("0")
	cell_positions = selected_level.get_used_cells()
	width = selected_level.get_used_rect().size.x
	height = selected_level.get_used_rect().size.y
	
	Logger.debug("Level size : " + str(width) + " x " + str(height))
	prepare_tilemap(width / 2, height / 2)

func _process(_delta):
	position_on_map = world_to_map(Nodes.player.position)
	
	if position_on_map != old_position_on_map:
		compute_virtual_position()
		
		if virtual_x == 0 :
			if position_on_map.x > old_position_on_map.x :
				nb_x += 1
			else:
				nb_x -= 1
		
		if virtual_y == 0 :
			if position_on_map.y > old_position_on_map.y :
				nb_y += 1
			else:
				nb_y -= 1
				
		if  virtual_x == 0 or virtual_x == width / 2 or virtual_x == width:
			prepare_tilemap(virtual_x, virtual_y)

		Logger.debug("Map position : " + str(position_on_map))
		Logger.debug("Virtual position :  (" + str(virtual_x) + ", " + str(virtual_y) + ")")
		
		old_position_on_map = position_on_map


func compute_virtual_position() -> void:
	virtual_x = fmod(position_on_map.x, width)
	virtual_y = fmod(position_on_map.y, height)


func get_coord(pos:Vector2) -> Vector2 :
	var ax = int(fmod(pos.x, width))
	var ay = int(fmod(pos.y, height))
	if ax < 0:
		ax += width
	if ay < 0:
		ay += height
			
	return Vector2(ax, ay)


func prepare_tilemap(_x:int, _y:int) -> void :
	clear()
	Logger.debug("x range = " + str(_x - width) + " to " + str(_x + width + 1))
	for x in range (_x - width, _x + width + 1):
		for y in range (_y - height, _y + height + 1):
			set_cell(width * nb_x + x, height * nb_y + y, selected_level.get_cellv(get_coord(Vector2(x,y))))


func set_level() -> void :
	clear()
	for cell_position in cell_positions:
		set_cellv(cell_position, selected_level.get_cellv(cell_position))
	update_dirty_quadrants()


