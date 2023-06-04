extends Node
class_name City

var location : Vector2  # The Tile that this City is located on.
var player : Player  # The Player that owns this City.
var level : int

func _init(location : Vector2, player : Player):
	self.location = location
	self.player = player
	self.level = 0

# Get the index of the sprite for this city.
func get_sprite_index() -> int:
    return 0

