extends TileMap

const Levels = preload("res://scenes/world/Levels.tscn")
var selected_level
var old_position_on_map:Vector2
var position_on_map:Vector2

var virtual_x
var virtual_y
var nb_x = 0
var nb_y = 0
var cell_positions

func _ready():
	selected_level = Levels.instance().get_node("0")
	cell_positions = selected_level.get_used_cells()
	set_level()

func _process(_delta):
	position_on_map = world_to_map(Nodes.player.position)
	
	if position_on_map != old_position_on_map:
		virtual_x = fmod(position_on_map.x, 32)
		virtual_y = fmod(position_on_map.y, 32)
	
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
		
#		if virtual_x > 23 or virtual_y > 23: 
#			for y in range(0, virtual_y + 1 ):
#				for x in range(0, virtual_x + 1 ):
#					set_cell(32 * nb_x + x, 32 * nb_y + y, selected_level.get_cell(x, y))
#
		
		if virtual_x > 23 : 
			for y in range (-16, 17):
				for x in range(0, virtual_x + 1 ):
					set_cell(32 * (nb_x + 1) + x, virtual_y + y, selected_level.get_cell(x, get_y(virtual_y + y)))

#		if virtual_y > 23 : 
#			for y in range(0, virtual_y + 1 ):
#				for x in range (-16, 16):
#					set_cell(virtual_x + x * (nb_x + 1), 32 * (nb_y + 1) + y, selected_level.get_cell(virtual_x + x, y))	
		
		Logger.debug("Map position : " + str(position_on_map))
		Logger.debug("\tvirtual x = " + str(virtual_x) + "\t nb_x = " + str(nb_x))
		Logger.debug("\tvirtual y = " + str(virtual_y) + "\t nb_y = " + str(nb_y))
		
		old_position_on_map = position_on_map
	
		
func get_y(value:int) -> int :
	var a = int(fmod(value, 32))
	if a < 0:
		a += 32
	return a
	
	


func set_level() -> void :
	clear()
	for cell_position in cell_positions:
		set_cellv(cell_position, selected_level.get_cellv(cell_position))
	update_dirty_quadrants()


