extends VBoxContainer


func _ready():
	$text_size/spin_box.min_value = JotteryOptions.MIN_TEXT_SIZE


func get_options() -> JotteryOptions:
	var options = JotteryOptions.new()
	options.text_size = $text_size/spin_box.value
	options.wrap_tabs = $wrap_tabs/check_box.pressed
	return options


func set_options(options: JotteryOptions):
	$text_size/spin_box.value = options.text_size
	$wrap_tabs/check_box.pressed = options.wrap_tabs
