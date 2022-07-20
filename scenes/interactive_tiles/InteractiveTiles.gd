extends TileMap

enum TileIndex {
	CLOSED_CHEST, 
	LIFE_POTION,
	PURPLE_GEM,
}

const NO_CELL = -1
const ClosedChest = preload ("res://scenes/interactive_tiles/closed_chest/ClosedChest.tscn")
const LifePotion = preload ("res://scenes/interactive_tiles/life_potion/LifePotion.tscn")
const PurpleGem = preload ("res://scenes/interactive_tiles/purple_gem/PurpleGem.tscn")

var tile_scene_dictionnary = {
	TileIndex.CLOSED_CHEST : ClosedChest,	
	TileIndex.LIFE_POTION : LifePotion,
	TileIndex.PURPLE_GEM : PurpleGem,
}


func _ready():
	update_tiles()


func update_tiles() -> void:
	for cell_position in get_used_cells():
		var cell_index = get_cellv(cell_position)
		var replacement = tile_scene_dictionnary.get(cell_index).instance()
		replacement.position = map_to_world(cell_position) * scale
		call_deferred("add_child", replacement)
		set_cellv(cell_position, NO_CELL)
