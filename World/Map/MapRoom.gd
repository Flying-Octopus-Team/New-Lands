var type = "empty"
var shape = ""
var direction = 0

func get_shape_code():
	if shape.length() > 1:
		var code = [shape[0], shape[1]]
		code.sort()
		code = code[0] + code[1]
		return code
	else:
		return shape
		
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
