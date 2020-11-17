extends CanvasLayer

onready var hp_bar = get_node('MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/Bars/HpBar')
onready var win_panel = get_node("MarginContainer/VBoxContainer/WinPanel")
onready var lose_panel = get_node("MarginContainer/VBoxContainer/LosePanel")
var player

func set_player_ref(player_ref):
	# setting player reference and load player statistics to ui
	player = player_ref
	hp_bar.load_player_hp(player_ref.health)

func on_player_hp_changed():
	hp_bar.change_actual_hp(player.health)
	
func on_player_died():
	lose_panel.visible = true
	
func on_player_enter_gate():
	win_panel.visible = true
