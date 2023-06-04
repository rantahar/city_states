extends TileMap

var Tile = preload("res://tile.gd")
onready var game = get_node("/root/Game")

func _process(delta):
	for city in game.cities:
		set_cellv(city.location, city.level)

