extends WindowDialog

var vbox : VBoxContainer
var label : Label
var description1 : Label
var description2 : Label
var description : RichTextLabel
var improvement_option : OptionButton
var confirm_button : Button

var labels = {}

var bold_font = preload("res://fonts/Lato/Lato-Bold.tres")

var current_tile

func _ready():
	print("Popup ready")
	vbox = VBoxContainer.new() 
	add_child(vbox)
	
	label = Label.new()
	vbox.add_child(label)
	
	var description_hbox = HBoxContainer.new()
	description1 = Label.new()
	description2 = Label.new()
	description1.add_font_override("font", bold_font)
	description_hbox.add_child(description1)
	description_hbox.add_child(description2)
	vbox.add_child(description_hbox)
	
	improvement_option = OptionButton.new()
	confirm_button = Button.new()
	vbox.add_child(improvement_option)
	vbox.add_child(confirm_button)
	confirm_button.text = "Confirm"
	confirm_button.connect("pressed", self, "_on_confirm_button_pressed")

func update_popup(tile):
	for improvement in labels.keys():
		vbox.remove_child(labels[improvement])
		labels.erase(improvement)
	
	current_tile = tile
	# Update the label with the tile's coordinates
	label.text = str(tile.x) + ", " + str(tile.y)
	# Update the rich text label with the tile's type
	description1.text = "Terrain Type: " 
	description2.text = tile.get_terrain_string()
	
	for improvement in tile.current_improvements.keys():
		var new_label = Label.new()
		new_label.name = improvement
		new_label.text = improvement
		vbox.add_child(new_label)
		labels[improvement] = new_label
	
	improvement_option.clear()
	for improvement in tile.get_available_improvements():
		improvement_option.add_item(improvement)
	
	self.popup_centered_minsize()
	self.rect_position = Vector2(200, 200)
	self.popup()


func _on_tile_clicked(tile):
	update_popup(tile)

func _on_confirm_button_pressed():
	var selected_improvement = improvement_option.get_selected_id()
	selected_improvement = improvement_option.get_item_text(selected_improvement)
	var root_node = get_tree().root.get_node("Game")
	root_node.improve_tile(current_tile, selected_improvement)
	update_popup(current_tile)

func _gui_input(event):
	if is_visible_in_tree():
		if event is InputEventMouseButton and event.pressed:
			if get_global_rect().has_point(event.global_position):
				# Handle input here for this window
				get_tree().set_input_as_handled()


