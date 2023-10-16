extends Node

class_name Player
var score = 0
var resources = []
var is_done = false

func start_turn():
	is_done = false

func turnActions():
	pass

func mark_done():
	return self.is_done

