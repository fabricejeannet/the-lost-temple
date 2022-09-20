extends TileMap

const Levels = preload("res://scenes/world/Levels.tscn")

var template:TileMap
var width_in_tiles
var height_in_tiles
var old_position = Vector2.ZERO
var current_position
var delta_x:int = 16
var nb_x:int = 0

var temp:Vector2

func _ready():
	set_template(Levels.instance().get_node("0"))
#	current_position = get_virtual_position_from(world_to_map(Nodes.player.position))
#	set_tiles_for_player_at(current_position)

func _process(delta):
	current_position = get_virtual_position_from(world_to_map(Nodes.player.position))
	if current_position != old_position:

		if Nodes.player.orientation == Constants.Orientations.NEUTRAL or Nodes.player.orientation == Constants.Orientations.EAST or Nodes.player.orientation == Constants.Orientations.NORTH_EAST or Nodes.player.orientation == Constants.Orientations.SOUTH_EAST:
			delta_x += 1
			if delta_x > 15:
				nb_x +=1
				temp = Vector2(delta_x * nb_x, current_position.y)
				Logger.debug("Temp : " + str(temp))
				set_tiles_for_player_at(temp)
				delta_x = 0
		elif Nodes.player.orientation == Constants.Orientations.NEUTRAL or Nodes.player.orientation == Constants.Orientations.WEST or Nodes.player.orientation == Constants.Orientations.NORTH_WEST or Nodes.player.orientation == Constants.Orientations.SOUTH_WEST:
			delta_x -= 1
			if delta_x < 0:
				nb_x -=1
				temp = Vector2(delta_x * abs(nb_x), current_position.y)
				Logger.debug("Temp : " + str(temp))
				set_tiles_for_player_at(temp)
				delta_x = 31	
			
		
		Logger.debug("Current position : " + str(current_position) + " delta_x : " + str(delta_x) + " nb_x : " + str(nb_x))

		old_position = current_position



func set_template(_template:TileMap) -> void:
	template = _template
	var template_used_rect = template.get_used_rect()
	width_in_tiles = template_used_rect.size.x
	height_in_tiles = template_used_rect.size.y


func get_virtual_position_from(given_position:Vector2) -> Vector2:
	var given_x = given_position.x
	if given_x < 0:
		given_x += width_in_tiles
	var given_y = given_position.y
	if given_y < 0:
		given_y += height_in_tiles
	return Vector2(int(fmod(given_x, width_in_tiles)), int(fmod(given_y, height_in_tiles)))


func set_tiles_for_player_at(given_position:Vector2) -> void:
	Logger.debug("Resetting tiles")
	clear()
	for x in range(given_position.x - width_in_tiles, given_position.x + width_in_tiles):
		for y in range(given_position.y - height_in_tiles, given_position.y + height_in_tiles):
			set_cell(x, y, template.get_cellv(get_virtual_position_from(Vector2(x,y))))
	Logger.debug("Level size : " + str(get_used_rect().size))
