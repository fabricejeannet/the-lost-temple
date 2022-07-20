extends TileMap

enum TileIndex {
	CLOSED_CHEST, 
	OPENED_CHEST,
}

const NO_CELL = -1

var ClosedChest = preload ("res://scenes/ClosedChest.tscn")

var tile_scene_dictionnary = {
	TileIndex.CLOSED_CHEST : ClosedChest,	
}


func _ready():
	for cell_position in get_used_cells():
		var cell_index = get_cellv(cell_position)
		var replacement = tile_scene_dictionnary.get(cell_index).instance()
		replacement.position = map_to_world(cell_position) * scale
		add_child(replacement)
		set_cellv(cell_position, NO_CELL)
