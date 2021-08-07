extends ConfirmationDialog


func _ready():
	get_ok().text = "Rename"


func set_new_name_prefill(prefill):
	$v_box_container/new_name.text = prefill


func get_new_name():
	return $v_box_container/new_name.text


func _on_about_to_show():
	$v_box_container/new_name.call_deferred("grab_focus")
	$v_box_container/new_name.call_deferred("select_all")


func _on_new_name_text_entered(new_text):
	get_ok().emit_signal("pressed")
