extends "res://Hub/Stations/shared/Station.gd"

# Changes to World node, therefore starting the run
# Player gets spawned by World, so there's no need to transfer him
func station_used():
	get_tree().change_scene("res://World/World.tscn")
