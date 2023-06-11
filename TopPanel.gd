extends Panel

onready var game = get_node("/root/Game")

signal end_turn_button_pressed

func _ready():
	$EndTurnButton.connect("pressed", self, "_on_EndTurnButton_pressed")

func _on_EndTurnButton_pressed():
	emit_signal("end_turn_button_pressed")
