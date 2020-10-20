extends CanvasLayer

onready var hp_bar = get_node('MarginContainer/HBoxContainer/CenterContainer/Bars/HpBar')
var player

func set_player_ref(player_ref):
	# setting player reference and load player statistics to ui
	player = player_ref
	hp_bar.load_player_hp(player_ref.health)

func on_player_hp_changed():
	hp_bar.change_actual_hp(player.health)
