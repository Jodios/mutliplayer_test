extends Node2D

var peer = ENetMultiplayerPeer.new()

func _ready():
	if ServerData.LOCALHOST:
		get_tree().change_scene_to_file("res://server/server.tscn")
	else:
		peer.create_client(ServerData.ADDRESS, ServerData.PORT)
		multiplayer.multiplayer_peer = peer
		multiplayer.connected_to_server.connect(_on_successful_connection)
		multiplayer.connection_failed.connect(_on_failed_connection)

func _on_successful_connection():
	print("SUCCESFULLY CONNECTED...")
	
func _on_failed_connection():
	print("FAILED TO CONNECT...")
