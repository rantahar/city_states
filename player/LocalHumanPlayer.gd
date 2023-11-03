extends Player
class_name LocalHumanPlayer

func end_turn():
	self.is_done = true

func construct_improvement(tile, improvement):
	tile.construct_improvement(improvement)

