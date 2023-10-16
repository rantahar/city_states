extends Node2D

var players = [
	LocalHumanPlayer.new(),
	AIPlayer.new()
]
var grid = []
var cities = []

var current_turn = 1
enum GameState { PLAYER_TURN, AI_TURN, END_GAME }

var currentState = GameState.PLAYER_TURN
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
	print("Map init")
	pass
	

func _ready():
	print("Map ready")
	var grid_width = len(map)
	var grid_height = len(map[0])
	for i in range(grid_width):
		grid.append([])
		for j in range(grid_height):
			grid[i].append(Tile.new(self, map[j][i], i, j))
	
	grid[1][1].create_city(players[0])
	grid[3][3].create_city(players[1])

	$Map.connect("tile_clicked", $UI/TilePopup, "_on_tile_clicked")
	$UI/TopPanel.connect("end_turn_button_pressed", self, "end_turn")
	
	call_deferred("create_initial_cities")
	

func update_turn_label():
	var turn_label = $UI/TopPanel/TurnLabel
	turn_label.text = "Turn: " + str(current_turn)

func end_turn():
	current_player.end_turn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if players[playerIndex].mark_done():
		playerIndex = (playerIndex + 1)
		if playerIndex >= players.size():
			playerIndex = 0
			current_turn +=1
			update_turn_label()
			
		current_player = players[playerIndex]
		current_player.start_turn()

		if players[playerIndex] is LocalHumanPlayer:
			currentState = GameState.PLAYER_TURN
		elif players[playerIndex] is AIPlayer:
			currentState = GameState.AI_TURN
	
	current_player.turnActions()

