extends Node2D

var drag_previous_position = Vector2()
var zoom_speed = 0.1
var min_zoom = 0.5
var max_zoom = 2.0
var map_move_speed = 10
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
	
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	
	self.position += direction.normalized() * map_move_speed


func _unhandled_input(event):
	if event is InputEventMouseButton:
		var old_scale = self.scale.x
		# dragging the map
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			drag_previous_position = event.position
		elif not event.is_pressed() and event.button_index == BUTTON_LEFT:
			drag_previous_position = Vector2()
		# zooming
		if event.is_pressed() and event.button_index == BUTTON_WHEEL_UP:
			self.scale.x = clamp(self.scale.x + zoom_speed, min_zoom, max_zoom)
			self.scale.y = clamp(self.scale.y + zoom_speed, min_zoom, max_zoom)
		elif event.is_pressed() and event.button_index == BUTTON_WHEEL_DOWN:
			self.scale.x = clamp(self.scale.x - zoom_speed, min_zoom, max_zoom)
			self.scale.y = clamp(self.scale.y - zoom_speed, min_zoom, max_zoom)
		if old_scale != self.scale.x:
			var mouse_pos = get_local_mouse_position()
			self.position -= mouse_pos * (self.scale.x - old_scale)
	elif event is InputEventMouseMotion and drag_previous_position != Vector2():
		self.position -= drag_previous_position - event.position
		drag_previous_position = event.position
	





