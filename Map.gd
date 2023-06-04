extends Node2D

onready var game = get_node("/root/Game")

var drag_previous_position = Vector2()
var zoom_speed = 0.1
var min_zoom = 0.5
var max_zoom = 4.0
var map_move_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	# This enables processing of mouse events.
	set_process_input(true)

func _input(event):
	# Check if left mouse button is clicked.
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		# Get mouse position.
		var mouse_pos = get_global_mouse_position() - game.position
		# Convert to tile coordinates.
		var tile_pos = $BaseMap.world_to_map(mouse_pos)
		var clicked_tile = game.grid[tile_pos.x][tile_pos.y]
		
		if clicked_tile:
			var popup = get_node("/root/Game/UI/TilePopup")
			popup.update_popup(clicked_tile)
			
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
	
	
