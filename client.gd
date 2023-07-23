extends Node2D

var peer = ENetMultiplayerPeer.new()

@export var HOST: String         = "localhost"
@export var PORT: int            = 8080


func _ready():
	print("Creating Client")
	peer.create_client(HOST, PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.connected_to_server.connect(_on_successful_connection)

@rpc
func _on_player_connected(id):
	if id == 1: return
	var player = preload("res://character.tscn").instantiate()
	player.name = str(id)
	player.set_multiplayer_authority(id)
	call_deferred("add_child", player)
	
@rpc
func _load_previous_players(ids):
	print(ids)
	for id in ids:
		if id != multiplayer.get_unique_id():
			_on_player_connected(id)

func _on_successful_connection():
	print("Connected")

func _on_failed_connection():
	print("Failed to connect")

