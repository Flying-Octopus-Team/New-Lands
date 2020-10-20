extends CanvasLayer

onready var HP_BAR = get_node('MarginContainer/HBoxContainer/CenterContainer/Bars/HpBar')
var player

func set_player_ref(player_ref):
	# setting player reference and load player statistics to ui
	player = player_ref
	HP_BAR.load_player_hp(player_ref.health)

func on_player_get_damage(damage):
	HP_BAR.change_actual_hp(player.health - damage)
