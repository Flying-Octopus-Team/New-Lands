extends TextureProgress

func load_player_hp(max_hp_value):
	$MarginContainer/Counter/Max.text = str(max_hp_value)
	$MarginContainer/Counter/Actual.text = str(max_hp_value)
	max_value = max_hp_value
	value = max_hp_value

func change_actual_hp(hp_value):
	value = hp_value
	$MarginContainer/Counter/Actual.text = str(hp_value)
