extends Node

var peer = ENetMultiplayerPeer.new()

@export var MAX_CONNECTIONS: int = 4095
@export var PORT: int            = 8080

var player_ids = {}

	
func _ready():
	print("Creating Server")
	peer.create_server(PORT, MAX_CONNECTIONS)
	multiplayer.multiplayer_peer = peer
	_on_player_connected(1)
	peer.peer_connected.connect(func (new_player_id):
		await get_tree().create_timer(.3).timeout
		rpc("_on_player_connected", new_player_id)
		rpc_id(new_player_id, "_load_previous_players", player_ids)
		player_ids[new_player_id]={}
		_on_player_connected(new_player_id)
	)
	peer.peer_disconnected.connect(func (disconnected_player_id):
		print("Removing ", disconnected_player_id)
		player_ids.erase(disconnected_player_id)
	)

@rpc("authority","call_local")
func _on_player_connected(id):
	var player = preload("res://character.tscn").instantiate()
	player.name = str(id)
	player.set_multiplayer_authority(id)
	player.hide()
	print("adding ", id, " to server")
	call_deferred("add_child", player)
	
@rpc
func _load_previous_players(_ids):
	pass
