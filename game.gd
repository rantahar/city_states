extends Node2D

var players = [
	LocalHumanPlayer.new(),
	AIPlayer.new()
]
var grid = []
var cities = []

var current_turn = 1
var playerIndex = 0
var current_player = players[playerIndex]

var map = [
	[3, 3, 3, 3, 3],
	[3, 0, 0, 2, 3],
	[3, 0, 1, 2, 3],
	[3, 1, 1, 2, 3],
	[3, 3, 3, 3, 3]
]


func _init():
	print("Game init")
	pass

func create_city(tile, player):
	var city =  City.new(tile, player)
	tile.city = city
	cities.append(city)
	
	var building_layer = get_node("Map/BuildingLayer")
	building_layer.update_borders()

func _ready():
	print("Game ready")
	var grid_width = len(map)
	var grid_height = len(map[0])
	for i in range(grid_width):
		grid.append([])
		for j in range(grid_height):
			grid[i].append(Tile.new(map[j][i], i, j))
	
	for i in range(grid_width):
		for j in range(grid_height):
			var tile = grid[i][j]
			var neighbor_positions
			var neighbor_directions = ["west", "east", "northwest", "northeast", "southwest", "southeast"]
			if j % 2 == 0:
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

	
	create_city(grid[1][1], players[0])
	create_city(grid[3][3], players[1])
	
	$Map.connect("tile_clicked", $UI/TilePopup, "_on_tile_clicked")
	$UI/TopPanel.connect("end_turn_button_pressed", self, "end_turn")
	
	call_deferred("create_initial_cities")
	

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

