extends Player
class_name AIPlayer


func _init(player_number).(player_number):
	pass

func takeActions():
	# Take an action as the AI
	
	# At the end mark as done (could return earlier to allow repainting as the AI is
	# making moves) 
	is_done = true
