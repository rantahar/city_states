extends WindowDialog

# Assume we have these child nodes
onready var label = get_node("RowContainer/TileLabel")
onready var description = get_node("RowContainer/Description")
onready var labormaxtext = get_node("RowContainer/LaborContainer/BtnRight")

func update_popup(tile):
	# Update the label with the tile's coordinates
	label.text = str(tile.x) + ", " + str(tile.y)
	# Update the rich text label with the tile's type
	description.bbcode_text = "**Terrain Type:** " + tile.get_terrain_string()
	# Update the maximum labor count
	labormaxtext.text = "/5"
	self.popup_centered_minsize()
	self.rect_position = Vector2(200, 200)
	self.popup()
