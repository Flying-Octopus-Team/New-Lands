extends Node2D


signal map_drawn()

export var points = 15
export var room_size = 16
var map

func _ready():
	randomize()
	var map = prepare_general_map(points)
	place_rooms(map)
	emit_signal("map_drawn")


func prepare_general_map(points):
	var MapRoom = load("res://World/Map/MapRoom.gd")
	var direction = 0
	var map = []
	var room_type_costs = {
		"empty": [0, Color.gray],
		"small": [1, Color.yellow],
		"medium": [3, Color.orange],
		"large": [5, Color.red]
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
		points -= filtered_rooms[type][0]
		
		var previous_direction = direction
		direction = randi() % 3 - 1
		while (direction != 0) and (direction == -previous_direction):
			direction = randi() % 3 - 1
			
		map[-1].shape += get_direction_name(direction)
		map_room.shape += get_reverse_direction_name(direction)
		map.append(map_room)
	map[-1].type = "boss"
	
	return map


func place_rooms(map) -> void:
	var variants = load("res://Rooms/RoomList.gd").new().rooms
	var position = Vector2(0, 0)
	for map_room in map:
		var fitting_rooms = variants[map_room.get_room_type()][map_room.get_shape_code()]
		var room = fitting_rooms[randi() % fitting_rooms.size()].instance()
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


func filter_types(types, condition) -> Dictionary:
	var filtered = {}
	for key in types.keys():
		if types[key][0] <= condition:
			filtered[key] = types[key]
	return filtered


func get_direction_name(direction) -> String:
	if direction == 0:
		return "N"
	elif direction == -1:
		return "W"
	else:
		return "E"


func get_reverse_direction_name(direction) -> String:
	if direction == 0:
		return "S"
	elif direction == -1:
		return "E"
	else:
		return "W"


func get_direction_from_name(name) -> int:
	if name == "S":
		return 0
	elif name == "E":
		return -1
	else:
		return 1


"""func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$Camera2D.offset.x -= 5000*delta
	elif Input.is_action_pressed("ui_right"):
		$Camera2D.offset.x += 5000*delta
	if Input.is_action_pressed("ui_up"):
		$Camera2D.offset.y -= 5000*delta
	elif Input.is_action_pressed("ui_down"):
		$Camera2D.offset.y += 5000*delta"""
