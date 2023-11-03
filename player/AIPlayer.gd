extends Player
class_name AIPlayer

func takeActions():
	# Take an action as the AI
	
	# At the end mark as done (could return earlier to allow repainting as the AI is
	# making moves) 
	is_done = true
