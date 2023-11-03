extends Node
class_name City

var location : Vector2  # The Tile that this City is located on.
var player : Player  # The Player that owns this City.
var level : int

var associated_tiles = []

func _init(_location : Vector2, _player : Player):
	self.location = _location
	self.player = _player
	self.level = 0


