extends Node2D

var peer = ENetMultiplayerPeer.new()

func _ready():
	peer.create_server(ServerData.PORT, 20)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	if ServerData.LOCALHOST:
		add_player(multiplayer.get_unique_id())
		
func add_player(id):
		print("adding player ", id)
		var player = preload("res://shared/character.tscn").instantiate()
		player.name = str(id)
		call_deferred("add_child", player)

func remove_player(id):
	for n in get_children():
		if n.name == str(id):
			n.queue_free()
