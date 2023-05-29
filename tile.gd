extends Reference

enum Terrain { PLAINS, MOUNTAIN, FOREST, WATER }

var terrain = Terrain.PLAINS

func _init(_terrain = Terrain.PLAINS):
	terrain = _terrain

func set_terrain(_terrain):
	terrain = _terrain

func get_terrain():
	return terrain
	