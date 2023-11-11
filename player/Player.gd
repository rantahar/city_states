extends Node

class_name Player
var score = 0
var resources = []
var is_done = false

var color: Color = Color(1, 1, 1, 1)

# A list of easily distinguishable colors. Each new player takes the next available color.
var color_options = [
	Color('e6194b'), # Red
	Color('ffe119'), # Yellow
	Color('4363d8'), # Blue
	Color('f58231'), # Orange
	Color('911eb4'), # Purple
	Color('42d4f4'), # Cyan
	Color('f032e6'), # Magenta
	Color('bfef45'), # Lime
	Color('fabebe'), # Pink
	Color('008080'), # Teal
	Color('e6beff'), # Violet
	Color('9a6324'), # Brown
	Color('6cd48b'), # Green
	# Add more colors as needed
]

func generate_random_color():
	return Color(randf(), randf(), randf())

func _init(player_number):
	if player_number < color_options.size():
		color = color_options[player_number]
	else:
		print("Out of unique predefined colors. Using random color.")
		color = generate_random_color()

func start_turn():
	is_done = false

func takeActions():
	pass

func mark_done():
	return self.is_done

