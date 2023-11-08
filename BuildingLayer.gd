extends TileMap

onready var game = get_node("/root/Game")
var line_color := Color(1, 1, 1, 1.0)
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

func draw_tile_borders(tile):
	var tile_location = tile.location
	for direction in tile.neighbours.keys():
		var neighbour = tile.neighbours[direction]
		var neighbor_pos = neighbour.location
		if neighbour.player_owner != tile.player_owner:
			var border_line = Line2D.new()
			border_line.width = line_width
			border_line.default_color = line_color
			border_nodes.append(border_line) # Keep track for later removal

			var dir = neighbor_pos - tile_location
			var start_point = map_to_world(tile_location) + dir_to_edge_offset(dir, true)
			var end_point = map_to_world(tile_location) + dir_to_edge_offset(dir, false)
			print(tile_location, direction, start_point, end_point)
			border_line.add_point(Vector2(40, 40))
			border_line.add_point(Vector2(0, 0))

			add_child(border_line)


func dir_to_edge_offset(direction, start_point):
	var cell_size: Vector2 = get_cell_size()
	var angle_deg: float
	var radius = cell_size.x / (2.0 * cos(PI / 6.0))
	
	match direction:
		"east":
			angle_deg = 0
		"southeast":
			angle_deg = PI / 3.0
		"southwest":
			angle_deg = 2 * PI / 3.0
		"west":
			angle_deg = 3 * PI / 3.0 
		"northwest":
			angle_deg = 4 * PI / 3.0
		"northeast":
			angle_deg = 5 * PI / 3.0
		
	# Convert the angle from degrees to radians for calculation
	var angle_rad = deg2rad(angle_deg)
	
	# Calculate the offset for an individual corner
	return Vector2(radius * cos(angle_rad), radius * sin(angle_rad))


