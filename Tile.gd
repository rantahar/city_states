extends Reference
class_name Tile

enum Terrain { PLAINS, MOUNTAIN, FOREST, WATER }

var location : Vector2
var x : int
var y : int
var terrain = Terrain.PLAINS
var city : City = null
var resources = []
var current_improvements = {}

var food_production = 0
var labor_saving = 0

var available_improvements = {
	"Road": {"travel_time": -2},
	"Farm": {"food_production": +2},
	"Mine": {"labor_saving": +1}
}


func _init(_terrain = Terrain.PLAINS, _x = 0, _y = 0):
	terrain = _terrain
	x = _x
	y = _y
	location = Vector2(_x, _y)
	
	if terrain == Terrain.WATER:
		food_production += 2
	if terrain == Terrain.FOREST:
		food_production += 1
		labor_saving += 1
	if terrain == Terrain.PLAINS:
		food_production += 1

func _ready():
	print("Tile ready")
	pass

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


func get_available_improvements():
	var _available_improvements = []
	for improvement in available_improvements.keys():
		if not current_improvements.get(improvement, false): # Check if the current tile does not have this improvement
			_available_improvements.append(improvement)
	
	return _available_improvements


func construct_improvement(improvement):
	if not improvement in get_available_improvements():
		return false
	current_improvements[improvement] = true
	


