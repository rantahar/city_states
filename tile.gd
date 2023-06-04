extends Reference
class_name Tile

enum Terrain { PLAINS, MOUNTAIN, FOREST, WATER }

var location : Vector2
var x : int
var y : int
var terrain = Terrain.PLAINS
var city : City = null

func _init(_terrain = Terrain.PLAINS, _x = 0, _y = 0):
	terrain = _terrain
	x = _x
	y = _y
	location = Vector2(_x, _y)

func set_terrain(_terrain):
	terrain = _terrain

func get_terrain():
	return terrain

func get_terrain_string():
	match terrain:
		Terrain.PLAINS:
			return("Plains")
		Terrain.MOUNTAIN:
			return("Mountain")
		Terrain.FOREST:
			return("Forest")
		Terrain.WATER:
			return("Water")
		_:
			return("")



