extends TileMap

const Levels = preload("res://scenes/world/Levels.tscn")
var selected_level
var old_virtual_position:Vector2
var virtual_position:Vector2
var old_modulo_x = 0
var coeff_x:int = 1

func _ready():
	selected_level = Levels.instance().get_node("0")
	set_level()

func _process(_delta):
	virtual_position = world_to_map(Nodes.player.position)
	if virtual_position != old_virtual_position:
		Logger.debug("Map position : " + str(virtual_position))
		old_virtual_position = virtual_position
	
	if virtual_position.x > 31 * coeff_x:
		coeff_x += 1
	
	var modulo_x = fmod(virtual_position.x, 31 * coeff_x)
	
	if modulo_x > old_modulo_x:
		Logger.debug ("Modulo x = " + str(modulo_x))
		old_modulo_x = modulo_x
		
	
	if modulo_x > 16:
		for y in range (-16, 16):
			for x in range(0, modulo_x -1):
				set_cell(32 + x, virtual_position.y + y, selected_level.get_cell(x, virtual_position.y + y))
			
		

func set_level() -> void :
	var cell_positions = selected_level.get_used_cells()
	for cell_position in cell_positions:
		set_cellv(cell_position, selected_level.get_cellv(cell_position))
	update_dirty_quadrants()
