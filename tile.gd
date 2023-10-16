extends Reference
class_name Tile

var game = null

enum Terrain { PLAINS, MOUNTAIN, FOREST, WATER }

var location : Vector2
var x : int
var y : int
var terrain = Terrain.PLAINS
var city : City = null
var level = 1

func _init(_game, _terrain = Terrain.PLAINS, _x = 0, _y = 0):
	game = _game
	terrain = _terrain
	x = _x
	y = _y
	location = Vector2(_x, _y)

func _ready():
	print("Tile ready")
	pass

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

func get_production():
	if not city == null:
		return({})
	match terrain:
		Terrain.PLAINS:
			return({"food": 1})
		Terrain.MOUNTAIN:
			return({})
		Terrain.FOREST:
			return({"food": 1, "labor": 1})
		Terrain.WATER:
			return({"food": 1})
		_:
			return({})

func create_city(player):
	city = City.new(location, player)
	game.cities.append(city)

func level_up():
	level += 1
