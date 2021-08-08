extends Resource
class_name JotteryOptions


enum JotteryTheme {
	LIGHT,
	DARK
}


var text_size: float = 16 setget set_text_size
var wrap_tabs: bool = true
var theme = JotteryTheme.LIGHT

const MIN_TEXT_SIZE = 8


func set_text_size(new_text_size):
	if new_text_size > MIN_TEXT_SIZE:
		text_size = new_text_size


static func theme_to_text(theme):
	if theme == JotteryTheme.LIGHT:
		return 'light'
	elif theme == JotteryTheme.DARK:
		return 'dark'


static func theme_from_text(text):
	if text == 'light':
		return JotteryTheme.LIGHT
	elif text == 'dark':
		return JotteryTheme.DARK


var light_theme_scene = preload("res://theme/jottery_theme_light.tres")
var dark_theme_scene = preload("res://theme/jottery_theme_dark.tres")


func get_theme_scene():
	if theme == JotteryTheme.LIGHT:
		return light_theme_scene
	elif theme == JotteryTheme.DARK:
		return dark_theme_scene
		
