extends TileMap

var points
# Dictionary of enemies that can spawn in rooms. Format is preloaded monster: cost
# This only applies to normal enemies, bosses will be handled in different way
var enemies = {
	preload("res://Entities/Enemies/shared/Enemy.tscn"): 3,
}


func _ready():
	spawn_enemies()


func spawn_enemies():
	while points > 0:
		randomize()
		var spawns = $Spawnpoints.get_children()
		var spawn = spawns[randi() % spawns.size()]
		spawns.erase(spawn)
		var available_enemies = filter_enemies(enemies, points)
		if available_enemies.size() > 0:
			var enemy = available_enemies[randi() % available_enemies.size()]
			points -= enemy[1]
			enemy = enemy[0].instance()
			enemy.position = spawn.position
			add_child(enemy)
		else:
			break

# Only returns enemies that can be spawn with available points
func filter_enemies(types, condition) -> Dictionary:
	var filtered = []
	for key in types.keys():
		if types[key] <= condition:
			filtered.append([key, types[key]])
	return filtered
