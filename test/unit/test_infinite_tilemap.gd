extends GutTest

const Levels = preload("res://scenes/world/Levels.tscn")
const InfiniteTileMap = preload("res://scenes/world/InfiniteTileMap.gd")

var template:TileMap
var infinite_tilemap:TileMap


func before_each():
	template = Levels.instance().get_node("0")
	infinite_tilemap = InfiniteTileMap.new()	


func test_can_set_a_template() -> void:
	infinite_tilemap.set_template(template)
	assert_eq(infinite_tilemap.template, template)
#	assert_eq(infinite_tilemap.width, template.get_used_rect().size.x)


func after_each():
	template.free()
	infinite_tilemap.free()
	
