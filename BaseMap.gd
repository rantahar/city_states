extends TileMap

onready var game = get_node("/root/Game")


func _process(delta):
	# Set cells 
	for i in range(len(game.grid)):
		for j in range(len(game.grid[0])):
			match game.grid[i][j].terrain:
				Tile.Terrain.PLAINS:
					set_cell(i, j, 1)
				Tile.Terrain.FOREST:
					set_cell(i, j, 0)
				Tile.Terrain.MOUNTAIN:
					set_cell(i, j, 3)
				Tile.Terrain.WATER:
					set_cell(i, j, 2)
				_:
					set_cell(i, j, -1)

