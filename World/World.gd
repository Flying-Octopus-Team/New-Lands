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
	prepare_hub()

func spawn_player():
	var Player = preload("res://Entities/Player/Player.tscn")
	player = Player.instance()
	# Only first room has node that marks player spawnpoint
	player.global_position = map.get_children()[0].get_node("PlayerSpawn").global_position
	add_child(player)

func prepare_hub():
	# sending reference to the player
	$HUD.set_player_ref(player)
	# connecting signals
	player.get_node("HitboxArea").connect('get_damage', $HUD, 'on_player_get_damage')
