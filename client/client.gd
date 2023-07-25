extends Node2D

var peer = ENetMultiplayerPeer.new()
var PORT = 80
var ADDRESS = "testing.jodios.com"

func _ready():
	if ServerData.LOCALHOST:
		get_tree().change_scene_to_file("res://server/server.tscn")
	else:
		print("CONNECTING TO ", ADDRESS, ":", PORT)
		var err = peer.create_client(ADDRESS, PORT)
		if err != OK :
			print("FAILED TO CREATE CLIENT")
		multiplayer.multiplayer_peer = peer
		multiplayer.connected_to_server.connect(_on_successful_connection)
		multiplayer.connection_failed.connect(_on_failed_connection)

func _on_successful_connection():
	print("SUCCESFULLY CONNECTED...")
	
func _on_failed_connection():
	print("FAILED TO CONNECT...")
