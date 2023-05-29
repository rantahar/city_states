extends TileMap

var Tile = preload("res://tile.gd")
onready var info_label = get_node("/root/Game/UI/Label")
onready var game = get_node("/root/Game")

func set_cells_map():
	for i in range(len(game.grid)):
		for j in range(len(game.grid[0])):
			match game.grid[i][j].terrain:
				Tile.Terrain.PLAINS:
					set_cell(i, j, 1)
				Tile.Terrain.FOREST:
					set_cell(i, j, 0)
				Tile.Terrain.MOUNTAIN:
					set_cell(i, j, 2)
				Tile.Terrain.WATER:
					set_cell(i, j, 3)
				_:
					set_cell(i, j, -1)



# Called when the node enters the scene tree for the first time.
func _ready():
	# This enables processing of mouse events.
	set_process_input(true)

func _input(event):
	# Check if left mouse button is clicked.
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		# Get mouse position.
		var mouse_pos = get_global_mouse_position()
		# Convert to tile coordinates.
		var tile_pos = world_to_map(mouse_pos)
		var tile_type = get_cell(tile_pos.x, tile_pos.y)
		# Print the tile coordinates.
		info_label.text = "Tile position: " + str(tile_pos) + ", Tile type: " + str(tile_type)

func _process(delta):
	set_cells_map()

