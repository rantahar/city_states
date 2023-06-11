extends Player
class_name LocalHumanPlayer

# Local human players actions are controlled by the UI, so the turnActions function
# does not need to be implemented. Instead, each UI element should call a function here.

func end_turn():
	self.is_done = true
