# This class is used in map_rooms array and has method necessary to generate real rooms later on in map generation
var type = "empty"
var shape = ""
var direction = 0

# Shape code is used to find the shape of the room, but it doesn't specify which side is the entrance, and which is the exit
# It's used so that you don't have to make 2 different lists of variant for a room that goes right to left and left to right
func get_shape_code():
	if shape.length() > 1:
		var code = [shape[0], shape[1]]
		code.sort()
		code = code[0] + code[1]
		return code
	else:
		return shape

# Type variable holds the fight type that will occur in this room
# This function returns the size of the room
func get_room_type():
	match type:
		"entrance":
			return "entrance"
		"boss":
			return "boss"
		"empty", "small":
			return "small"
		"medium", "large":
			return "large"

# Returns how many points the room has to spawn enemies inside of itself
func get_enemy_points():
	match type:
		"empty", "entrance", "boss":
			return 0
		"small":
			return 3
		"medium":
			return 5
		"large":
			return 10
