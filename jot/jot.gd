extends TextEdit


func _ready():
	add_to_group("jots")
	# Remove the "Clear" option from the right click menu.
	get_menu().remove_item(8)


func get_jot_text():
	return text


func set_jot_text(new_text):
	text = new_text
