extends Node2D


signal map_drawn()

export var points = 15
# Size of each room in tiles (rooms are room_size x room_size tiles)
export var room_size = 16
var map

func _ready():
	randomize()
	# Create array of abstract rooms, that will be used to generate real ones
	# You can think of it kind of like the dungeon map in Darkest Dungeon
	var map = prepare_general_map(points)
	# Place room tilemaps using map array.
	place_rooms(map)
	# Let the World know that map is now drawn and it can start spawning the player
	emit_signal("map_drawn")


func prepare_general_map(points):
	var MapRoom = load("res://World/Map/MapRoom.gd")
	# 0 means vertical, -1 and 1 mean horizontal
	# Thought about making this and enum, but I'll leave it like this for now
	var direction = 0
	var map = []
	# Keys mean how big a fight is in that room, value is it's point cost
	var room_type_costs = {
		"empty": 0,
		"small": 1,
		"medium": 3,
		"large": 5
	}
	
	# Create entrance room
	var room = MapRoom.new()
	room.type = "entrance"
	map.append(room)
	
	# Create rest of the rooms
	while points > 0:
		var map_room = MapRoom.new()
		var filtered_rooms = filter_types(room_type_costs, points)
		var type = filtered_rooms.keys()[randi() % filtered_rooms.size()]
		map_room.type = type
		points -= filtered_rooms[type]
		
		var previous_direction = direction
		direction = randi() % 3 - 1
		while (direction != 0) and (direction == -previous_direction):
			direction = randi() % 3 - 1
			
		map[-1].shape += get_direction_name(direction)
		map_room.shape += get_reverse_direction_name(direction)
		map.append(map_room)
	# Last room is a boss room
	map[-1].type = "boss"
	
	return map


func place_rooms(map) -> void:
	var variants = load("res://Rooms/RoomList.gd").new().rooms
	var position = Vector2(0, 0)
	for map_room in map:
		# Rooms that are correct shape
		var fitting_rooms = variants[map_room.get_room_type()][map_room.get_shape_code()]
		var room = fitting_rooms[randi() % fitting_rooms.size()].instance()
		# Where to put the room on the map, relative to the previous one
		var entrance_direction = get_direction_from_name(map_room.shape[0])
		if entrance_direction == 0:
			position += Vector2(0, -room.cell_size[0] * room_size)
		elif entrance_direction == -1:
			position += Vector2(-room.cell_size[0] * room_size, 0)
		else:
			position += Vector2(room.cell_size[0] * room_size, 0)

		room.points = map_room.get_enemy_points()
		room.position = position
		add_child(room)


# Return only types of room that the system can afford using points left
func filter_types(types, condition) -> Dictionary:
	var filtered = {}
	for key in types.keys():
		if types[key] <= condition:
			filtered[key] = types[key]
	return filtered

# Those are direction you get, when you go deeper into level
# (vertical doors are on the northern side of the rooms etc.)
func get_direction_name(direction) -> String:
	if direction == 0:
		return "N"
	elif direction == -1:
		return "W"
	else:
		return "E"


# Those are direction you get, when you go back from level
# (vertical doors are on the southern side of the rooms etc.)
func get_reverse_direction_name(direction) -> String:
	if direction == 0:
		return "S"
	elif direction == -1:
		return "E"
	else:
		return "W"


# Convert direction's name to number
func get_direction_from_name(name) -> int:
	if name == "S":
		return 0
	elif name == "E":
		return -1
	else:
		return 1
