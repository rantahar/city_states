extends Node2D

var grid = []
var cities = []

enum GameState { PLAYER_TURN, AI_TURN, END_GAME }
var currentState = GameState.PLAYER_TURN
var playerIndex = 0

var players = [
	LocalHumanPlayer.new(),
	AIPlayer.new()
]

var map = [
	[3, 3, 3, 3, 3],
	[3, 0, 0, 2, 3],
	[3, 0, 1, 2, 3],
	[3, 1, 1, 2, 3],
	[3, 3, 3, 3, 3]
]


# Called when the node enters the scene tree for the first time.
func _init():
	var grid_width = len(map)
	var grid_height = len(map[0])
	for i in range(grid_width):
		grid.append([])
		for j in range(grid_height):
			grid[i].append(Tile.new(map[j][i], i, j))
	cities.append(City.new(Vector2(1, 1), players[0]))
	cities.append(City.new(Vector2(3, 3), players[1]))

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if players[playerIndex].is_done():
		playerIndex = (playerIndex + 1) % players.size()
		if players[playerIndex] is LocalHumanPlayer:
			currentState = GameState.PLAYER_TURN
		elif players[playerIndex] is AIPlayer:
			currentState = GameState.AI_TURN
	
	match currentState:
		GameState.PLAYER_TURN:
			# take inputs from the player UI
			pass
		_:
			# Just keep updating the map while the AI (or remote player) takes actions
			pass

