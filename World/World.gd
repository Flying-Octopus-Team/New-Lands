extends Node2D


var map
var player

func _ready():
	# Creating the map
	var Map = preload("res://World/Map/Map.tscn")
	map = Map.instance()
	map.connect("map_drawn", self, "_on_map_drawn")
	add_child(map)
	
func _on_map_drawn():
	spawn_player()
	prepare_hud()

func spawn_player():
	var Player = preload("res://Entities/Player/Player.tscn")
	player = Player.instance()
	# Only first room has node that marks player spawnpoint
	player.global_position = map.get_children()[0].get_node("PlayerSpawn").global_position
	add_child(player)

func prepare_hud():
	# sending reference to the player
	$HUD.set_player_ref(player)
	# connecting signals
	player.connect('hp_changed', $HUD, 'on_player_hp_changed')
	player.connect('player_died', $HUD, 'on_player_died')
	map.boss_room.get_node('EndGate').connect('player_enter_gate', $HUD, 'on_player_enter_gate')
