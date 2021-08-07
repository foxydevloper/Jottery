extends Control


export var default_text_size = 16
export var default_wrap_tabs = true

export var zoom_power = 1

export var jot_template: PackedScene

export var jot_tabs: NodePath
export var options_dialog: NodePath
export var options_selector: NodePath
export var rename_jot_dialog: NodePath

onready var jot_tabs_node = get_node(jot_tabs)
onready var options_dialog_node = get_node(options_dialog)
onready var options_selector_node = get_node(options_selector)
onready var rename_jot_dialog_node = get_node(rename_jot_dialog)

onready var jottery_theme = theme

var options = JotteryOptions.new()


func _ready():
	if JotterySaving.found_save():
		print("Found save file.")
		load_from_save()
	else:
		options.text_size = default_text_size
		options.wrap_tabs = default_wrap_tabs
	options_selector_node.set_options(options)
	update_options()
	get_tree().set_auto_accept_quit(false)


func new_jot():
	var jot = jot_template.instance()
	jot.name = 'Jot 1'
	jot_tabs_node.add_child(jot, true)
	jot_tabs_node.current_tab = jot_tabs_node.get_tab_count() - 1
	jot_tabs_node.get_current_tab_control().grab_focus()


func close_current_jot():
	jot_tabs_node.get_current_tab_control().queue_free()


func next_tab():
	if options.wrap_tabs:
		jot_tabs_node.current_tab = posmod(
			jot_tabs_node.current_tab + 1,
			jot_tabs_node.get_tab_count()
		)
	else:
		jot_tabs_node.current_tab += 1


func previous_tab():
	if options.wrap_tabs:
		jot_tabs_node.current_tab = posmod(
			jot_tabs_node.current_tab - 1,
			jot_tabs_node.get_tab_count()
		)
	else:
		jot_tabs_node.current_tab -= 1


func _input(event):
	if event.is_action_pressed("previous_tab"):
		previous_tab()
	elif event.is_action_pressed("next_tab"):
		next_tab()


func prompt_rename_current_jot():
	var current_jot_name = jot_tabs_node.get_current_tab_control().name
	rename_jot_dialog_node.set_new_name_prefill(current_jot_name)
	rename_jot_dialog_node.popup_centered()


func confirm_rename_jot():
	var new_jot_name = rename_jot_dialog_node.get_new_name()
	jot_tabs_node.get_current_tab_control().name = new_jot_name


func zoom_in():
	options.text_size += zoom_power
	update_options()


func zoom_out():
	options.text_size -= zoom_power
	update_options()


func open_options():
	options_selector_node.set_options(options)
	options_dialog_node.popup_centered()


func update_options():
	jottery_theme.default_font.size = options.text_size


func confirm_options_selector():
	options = options_selector_node.get_options()
	update_options()


func serialize_jots():
	var serialized_jots = []
	for jot in get_tree().get_nodes_in_group("jots"):
		serialized_jots.append({
			'name': jot.name,
			'text': jot.get_jot_text()
		})
	return serialized_jots


func load_serialized_jots(serialized_jots):
	for jot_tab in jot_tabs_node.get_children():
		jot_tab.queue_free()
	for serialized_jot in serialized_jots:
		var jot = jot_template.instance()
		jot.name = serialized_jot['name']
		jot.set_jot_text(serialized_jot['text'])
		jot_tabs_node.add_child(jot)


func save():
	var serialized_jots = serialize_jots()
	JotterySaving.save_jottery(options, serialized_jots)


func load_from_save():
	options = JotterySaving.load_jottery_options()
	load_serialized_jots(JotterySaving.load_serialized_jots())


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save()
		get_tree().quit()
