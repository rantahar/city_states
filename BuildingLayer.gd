extends TileMap

onready var game = get_node("/root/Game")
onready var map = get_node("/root/Game/Map")
var color_alpha := 0.4
var line_width := 20
var border_nodes := [] # Keep track of Line2D nodes for borders

func update_borders():
	for city in game.cities:
		set_cellv(city.tile.location, 0)
	# First clear all existing border lines
	for border_node in border_nodes:
		border_node.queue_free()
	border_nodes.clear()
	
	# Process each city for its controlled tiles
	for i in range(len(game.grid)):
		for j in range(len(game.grid[0])):
			var tile = game.grid[i][j]
			draw_tile_borders(tile)

func tile_center(tile):
	var cell_size: Vector2 = get_cell_size()
	var radius = cell_size.x / (2.0 * cos(PI / 6.0))
	var base_coord = map_to_world(tile.location)
	# Weird adjustment of 15 pixels due to tile shape
	var center_coord  = base_coord + Vector2(cell_size.x/2, radius-15)
	return (center_coord - map.position) / map.scale.x 

func draw_tile_borders(tile):
	if not tile.player_owner:
		return
	
	for direction in tile.neighbours.keys():
		var neighbour = tile.neighbours[direction]
		if neighbour.player_owner != tile.player_owner:
			var border_line = Line2D.new()
			border_line.width = line_width
			var color : Color = tile.player_owner.color
			border_line.default_color = Color(color.r, color.g, color.b, color_alpha)
			border_nodes.append(border_line) # Keep track for later removal
			
			var start_point = tile_center(tile) + dir_to_edge_offset(direction, true)
			var end_point = tile_center(tile) + dir_to_edge_offset(direction, false)
			border_line.add_point(start_point)
			border_line.add_point(end_point)
			
			add_child(border_line)

func dir_to_edge_offset(direction, start_point):
	var cell_size: Vector2 = get_cell_size()
	var angle: float
	var radius = cell_size.x / (2.0 * cos(PI / 6.0)) * 0.9
	
	match direction:
		"southeast":
			angle = 0
		"east":
			angle = PI / 3.0
		"northeast":
			angle = 2 * PI / 3.0
		"northwest":
			angle = 3 * PI / 3.0
		"west":
			angle = 4 * PI / 3.0
		"southwest":
			angle = 5 * PI / 3.0
	
	if not start_point:
		angle += PI / 3.0
		
	# Calculate the offset for an individual corner
	return Vector2(radius * sin(angle), radius * cos(angle))


