extends Node2D


var map
var player

func _ready():
	var Map = preload("res://World/Map/Map.tscn")
	map = Map.instance()
	map.connect("map_drawn", self, "_on_map_drawn")
	add_child(map)
	
func _on_map_drawn():
	spawn_player()


func spawn_player():
	var Player = preload("res://Entities/Player/Player.tscn")
	var player = Player.instance()
	player.global_position = map.get_children()[0].get_node("PlayerSpawn").global_position
	add_child(player)
