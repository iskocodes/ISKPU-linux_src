extends Control

var type
var title
var text
var export
var filepath = "user://exec.sh"

func execute():
	if $Icon/OptionButton.selected == 0:
		type = "--error"
	elif $Icon/OptionButton.selected == 1:
		type = "--warning"
	elif $Icon/OptionButton.selected == 2:
		type = "--info"
	elif $Icon/OptionButton.selected == 3:
		type = "--question"
	elif $Icon/OptionButton.selected == 4:
		type = "--entry"
	
	title = $Title.text
	text = $Content.text
	
	export = "#!/bin/bash
	zenity %s --title=\"%s\" --text=\"%s\" --width=400" % [type, title, text]
	
	write_to_file()
	var global = ProjectSettings.globalize_path(filepath)
	OS.create_process("/bin/bash", PackedStringArray(["+x", global]))
	
	if $CheckButton.button_pressed:
		get_tree().quit()

func write_to_file():
	var file = FileAccess.open(filepath, FileAccess.WRITE)
	if file :
		file.store_string(export)
	else:
		print("error")


func _on_execute() -> void:
	execute()
