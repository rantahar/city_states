extends Node
class_name City

var tile  # The Tile that this City is located on.
var player : Player  # The Player that owns this City.
var level : int

var associated_tiles = []

func _init(_tile, _player : Player):
	self.tile = _tile
	self.player = _player
	self.level = 0
	
	self.tile.city_owner = self
	self.tile.player_owner = player
	
	for direction in tile.neighbours.keys():
		var neighbour = tile.neighbours[direction]
		if neighbour.city_owner == null:
			neighbour.city_owner = self
		if neighbour.player_owner == null:
			neighbour.player_owner = player
	


