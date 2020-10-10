extends TileMap

var points
var enemies = {
	preload("res://Entities/ProtoEnemies/Green.tscn"): 1,
	preload("res://Entities/ProtoEnemies/Blue.tscn"): 3,
	preload("res://Entities/ProtoEnemies/Red.tscn"): 5
}

func _ready():
	while points > 0:
		randomize()
		var spawns = $Spawnpoints.get_children()
		var spawn = spawns[randi() % spawns.size()]
		spawns.erase(spawn)
		var available_enemies = filter_types(enemies, points)
		var enemy = available_enemies[randi() % available_enemies.size()]
		points -= enemy[1]
		enemy = enemy[0].instance()
		enemy.position = spawn.position
		add_child(enemy)
	
func filter_types(types, condition) -> Dictionary:
	var filtered = []
	for key in types.keys():
		if types[key] <= condition:
			filtered.append([key, types[key]])
	return filtered
