extends Node2D

var grid = []

var Tile = preload("res://tile.gd")

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
