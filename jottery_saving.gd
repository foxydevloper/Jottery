extends Node
class_name JotterySaving


const save_file_path = "user://jottery"


# Preferably, these methods would be in JotteryOptions.
# However, having the deserialize method there causes a cyclic dependency.
static func serialize_options(options):
	return {
		'text_size': options.text_size,
		'wrap_tabs': options.wrap_tabs
	}


static func deserialize_options(serialized_options):
	var new_options = JotteryOptions.new()
	new_options.text_size = serialized_options.get('text_size')
	new_options.wrap_tabs = serialized_options.get('wrap_tabs')
	return new_options


# store_var is not used as Jottery save files may be sharable in the future.
# Storing objects with store_var and get_var could be dangerous.
static func save_jottery(options, serialized_jots):
	var save_file = File.new()
	save_file.open(save_file_path, File.WRITE)
	save_file.store_line(JSON.print({
		'options': serialize_options(options),
		'jots': serialized_jots
	}))
	save_file.close()
	print("Jottery was saved.")


static func load_jottery_options():
	var save_file = File.new()
	save_file.open(save_file_path, File.READ)
	var loaded_save = JSON.parse(save_file.get_line()).result
	save_file.close()
	return deserialize_options(loaded_save['options'])


static func load_serialized_jots():
	var save_file = File.new()
	save_file.open(save_file_path, File.READ)
	var loaded_save = JSON.parse(save_file.get_line()).result
	save_file.close()
	return loaded_save['jots']


static func found_save():
	return File.new().file_exists(save_file_path)
