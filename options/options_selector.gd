extends VBoxContainer


func _ready():
	$text_size/spin_box.min_value = JotteryOptions.MIN_TEXT_SIZE
	$jottery_theme/menu_button.get_popup().connect("index_pressed", self, "theme_option_index_pressed")


func theme_option_index_pressed(idx):
	var new_theme_text = $jottery_theme/menu_button.get_popup().get_item_text(idx)
	$jottery_theme/menu_button.text = new_theme_text


func get_jottery_theme_from_text(theme_text: String):
	return JotteryOptions.theme_from_text(
		theme_text.to_lower().replace(' ', '_')  # Convert to snake_case.
	)


func get_jottery_theme_text(jottery_theme):
	return JotteryOptions.theme_to_text(jottery_theme).capitalize()

func get_options() -> JotteryOptions:
	var options = JotteryOptions.new()
	options.text_size = $text_size/spin_box.value
	options.wrap_tabs = $wrap_tabs/check_box.pressed
	options.theme = get_jottery_theme_from_text($jottery_theme/menu_button.text)
	return options


func set_options(options: JotteryOptions):
	$text_size/spin_box.value = options.text_size
	$wrap_tabs/check_box.pressed = options.wrap_tabs
	$jottery_theme/menu_button.text = get_jottery_theme_text(options.theme)
