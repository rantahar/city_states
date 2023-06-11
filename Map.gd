extends Node2D

onready var game = get_node("/root/Game")

signal tile_clicked(tile)

var drag_previous_position = Vector2()
var zoom_speed = 0.1
var min_zoom = 0.5
var max_zoom = 4.0
var map_move_speed = 10
var drag_threshold = 5  # How far the mouse must move to be considered a drag.
var click_timer
var mouse_start_pos
var mouse_moved = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# This enables processing of mouse events.
	set_process_input(true)
	click_timer = Timer.new()
	click_timer.wait_time = 0.2
	click_timer.one_shot = true
	add_child(click_timer)
	click_timer.connect("timeout", self, "_on_click_timer_timeout")

func _unhandled_input(event):
	# Check if left mouse button is clicked.
	if event is InputEventMouseButton:
		var old_scale = self.scale.x
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				# Get mouse position.
				mouse_start_pos = event.position
				mouse_moved = false
				drag_previous_position = event.position
				click_timer.start()
			else:
				click_timer.stop()
				drag_previous_position = Vector2()
				if not mouse_moved:
					handle_tile_click(event)
		elif event.button_index == BUTTON_WHEEL_UP:
			self.scale.x = clamp(self.scale.x + zoom_speed, min_zoom, max_zoom)
			self.scale.y = clamp(self.scale.y + zoom_speed, min_zoom, max_zoom)
		elif event.button_index == BUTTON_WHEEL_DOWN:
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
	

func _on_click_timer_timeout():
	# The mouse was held down long enough to be considered a drag.
	mouse_moved = true

func handle_tile_click(event):
	var global_mouse_pos = get_global_mouse_position()
	var zoom = self.scale.x
	var adjusted_mouse_pos = (global_mouse_pos - game.position) / zoom
	var tile_pos = $BaseMap.world_to_map(adjusted_mouse_pos)
	var clicked_tile = game.grid[tile_pos.x][tile_pos.y]
	
	if clicked_tile:
		emit_signal("tile_clicked", clicked_tile)

