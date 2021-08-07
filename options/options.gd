extends Resource
class_name JotteryOptions


var text_size: float setget set_text_size
var wrap_tabs: bool

const MIN_TEXT_SIZE = 8


func set_text_size(new_text_size):
	if new_text_size > MIN_TEXT_SIZE:
		text_size = new_text_size
