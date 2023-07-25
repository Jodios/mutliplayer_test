extends Node

const DEDICATED_SERVER = "dedicated_server"

func _ready():
	if "--server" in OS.get_cmdline_args() || OS.has_feature(DEDICATED_SERVER):
		get_tree().change_scene_to_file("res://server/server.tscn")
		
	$Panel/join.pressed.connect(func():
		ServerData.ADDRESS = $Panel/TextEdit.text
		get_tree().change_scene_to_file("res://client/client.tscn")
	)
		
	$Panel/host.pressed.connect(func():
		ServerData.LOCALHOST = true
		ServerData.ADDRESS = $Panel/TextEdit.text
		get_tree().change_scene_to_file("res://client/client.tscn")
	)
