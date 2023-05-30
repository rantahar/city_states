extends Node2D

var Tile = preload("res://tile.gd")

var drag_previous_position = Vector2()
var zoom_speed = 0.1
var min_zoom = 0.5
var max_zoom = 2.0

var grid = []
var map = [
	[1, 1, 1, 1, 1],
	[1, 0, 0, 2, 1],
	[1, 0, 2, 2, 1],
	[1, 3, 0, 2, 1],
	[1, 1, 1, 1, 1]
]

# Called when the node enters the scene tree for the first time.
func _init():
	var grid_width = len(map)
	var grid_height = len(map[0])
	for i in range(grid_width):
		grid.append([])
		for j in range(grid_height):
			grid[i].append(Tile.new(map[i][j]))

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
	





