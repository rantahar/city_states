extends Node2D
var city_scene = load("res://city/City.tscn")
var tile_scene = load("res://tile/Tile.tscn")

var players = [
	LocalHumanPlayer.new(0),
	AIPlayer.new(1)
]
var grid = []
var cities = []

var current_turn = 1
var playerIndex = 0
var current_player = players[playerIndex]

var map = [
	[3, 3, 3, 3, 3, 3],
	[3, 0, 0, 2, 3, 3],
	[3, 0, 1, 2, 2, 3],
	[3, 1, 1, 2, 3, 3],
	[3, 3, 3, 3, 3, 3]
]


func _init():
	print("Game init")
	pass

func create_city(tile, player):
	var map = $Map
	var city = city_scene.instance()
	map.add_child(city)
	print("T", tile.position, tile.x, tile.y)
	city.position = tile.position
	
	var building_layer = get_node("Map/BuildingLayer")
	building_layer.update_borders()

func _ready():
	print("Game ready")
	var grid_width = len(map[0])
	var grid_height = len(map)
	for i in range(grid_width):
		grid.append([])
		for j in range(grid_height):
			var tile = tile_scene.instance()
			tile.setup(map[j][i], i, j)
			if j % 2 == 1:
				tile.position = Vector2(i*316 + 127, j*254)
			else:
				tile.position = Vector2(i*316, j*254)
			grid[i].append(tile)
	
	for i in range(grid_width):
		for j in range(grid_height):
			var tile = grid[i][j]
			var neighbor_positions
			var neighbor_directions = ["west", "east", "northwest", "northeast", "southwest", "southeast"]
			if j % 2 == 1:
				neighbor_positions = [
					Vector2(i-1, j), Vector2(i+1, j), 
					Vector2(i, j-1), Vector2(i+1, j-1), 
					Vector2(i, j+1), Vector2(i+1, j+1)
				]
			else:
				neighbor_positions = [
					Vector2(i-1, j), Vector2(i+1, j), 
					Vector2(i-1, j-1), Vector2(i, j-1), 
					Vector2(i-1, j+1), Vector2(i, j+1)
				]
			
			for index in range(neighbor_positions.size()):
				var pos = neighbor_positions[index]
				if (pos.x >= 0 and pos.x < grid.size() and pos.y >= 0 and pos.y < grid[i].size()):
					var direction = neighbor_directions[index]
					tile.neighbours[direction] = grid[int(pos.x)][int(pos.y)]

	
	create_city(grid[0][0], players[0])
	create_city(grid[1][0], players[0])
	create_city(grid[1][1], players[0])
	create_city(grid[3][3], players[1])
	
	$Map.connect("tile_clicked", $UI/TilePopup, "_on_tile_clicked")
	$UI/TopPanel.connect("end_turn_button_pressed", self, "end_turn")
	

func update_turn_label():
	var turn_label = $UI/TopPanel/TurnLabel
	turn_label.text = "Turn: " + str(current_turn)

func end_turn():
	current_player.end_turn()
	
func improve_tile(tile, improvement):
	return current_player.construct_improvement(tile, improvement)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# If the player is done, go to the next player
	if players[playerIndex].is_done:
		playerIndex = (playerIndex + 1)
		if playerIndex >= players.size():
			playerIndex = 0
			current_turn +=1
			update_turn_label()
			
		current_player = players[playerIndex]
		current_player.start_turn()

	if players[playerIndex] is AIPlayer:
		current_player.takeActions()

