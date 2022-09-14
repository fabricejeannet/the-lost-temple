extends GutTest

const Levels = preload("res://scenes/world/Levels.tscn")
const InfiniteTileMap = preload("res://scenes/world/InfiniteTileMap.gd")

var template:TileMap
var infinite_tilemap:TileMap


func before_each():
#	template = Levels.instance().get_node("0")
	var tile_type = 0
	template = TileMap.new()
	for x in range (0, 32):
		for y in range (0, 32):
			template.set_cell(x, y, tile_type)
			tile_type += 1		
	
	template.update_dirty_quadrants()
	infinite_tilemap = InfiniteTileMap.new()	
	infinite_tilemap.set_template(template)


func test_template_has_1024_different_type_of_tile() -> void : 
	assert_eq(template.get_cell(0, 0), 0)
	assert_eq(template.get_cell(31, 31), 1023)


func test_can_set_a_template() -> void:
	assert_eq(infinite_tilemap.template, template)
	assert_eq(infinite_tilemap.width_in_tiles, 32)
	assert_eq(infinite_tilemap.height_in_tiles, 32)


func test_virtual_positions() -> void :
	var position_on_map
	var virtual_position

	position_on_map = Vector2(32,16)
	virtual_position = infinite_tilemap.get_virtual_position_from(position_on_map)
	assert_eq(virtual_position, Vector2(0, 16))

	position_on_map = Vector2(-1,16)
	virtual_position = infinite_tilemap.get_virtual_position_from(position_on_map)
	assert_eq(virtual_position, Vector2(31, 16))

	position_on_map = Vector2(-3,-5)
	virtual_position = infinite_tilemap.get_virtual_position_from(position_on_map)
	assert_eq(virtual_position, Vector2(29, 27))


func test_set_tiles() -> void:
	infinite_tilemap.set_tiles_for_player_at(Vector2(16,16))
	var used_rect = infinite_tilemap.get_used_rect()
	assert_eq(used_rect.size, Vector2(64,64))

func after_each():
	template.free()
	infinite_tilemap.free()
	
