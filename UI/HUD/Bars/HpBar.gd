extends TextureProgress
onready var tween = $Tween
var actual_health

func _process(delta):
	value = actual_health
	$MarginContainer/Counter/Actual.text = str(round(actual_health))

func load_player_hp(max_hp_value):
	$MarginContainer/Counter/Max.text = str(max_hp_value)
	$MarginContainer/Counter/Actual.text = str(max_hp_value)
	max_value = max_hp_value
	value = max_hp_value
	actual_health = max_hp_value

func change_actual_hp(hp_value):
	tween.interpolate_property(self, "actual_health", actual_health, hp_value, 0.2)
	if not tween.is_active():
		tween.start()
