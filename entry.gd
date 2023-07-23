extends Node2D


func _ready():
	$CenterContainer/Panel/join.pressed.connect(func():
		get_tree().change_scene_to_file("res://client.tscn")
	)
	$CenterContainer/Panel/host.pressed.connect(func():
		get_tree().change_scene_to_file("res://server.tscn")
	)
