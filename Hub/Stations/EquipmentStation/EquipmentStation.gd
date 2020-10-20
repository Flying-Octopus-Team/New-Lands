extends "res://Hub/Stations/shared/Station.gd"

"""
A station where the player can change his equipment.
It draws the UI and interfaces between it and EquipmentManager
"""


var ui = null


func station_used():
	if ui == null:
		draw_ui()
		# Disable player while viewing inventory
		get_parent().get_node("Player").set_process(false)

func use_canceled():
	if ui != null:
		ui.queue_free()
		ui = null
		# Enable player after exiting inventory screen
		get_parent().get_node("Player").set_process(true)


func draw_ui():
	ui = preload("res://UI/EquipmentScreen/EquipmentScreen.tscn").instance()
	add_child(ui)


# Equip the item on player. If different item was already equipped, put in back into chest
func _on_thumbnail_double_clicked(item):
	var currently_worn = EquipmentManager.worn_items[EquipmentManager.TYPES.keys()[item.type].capitalize()]
	EquipmentManager.worn_items[EquipmentManager.TYPES.keys()[item.type].capitalize()] = item
	EquipmentManager.chest.erase(item)
	if currently_worn != null:
		EquipmentManager.chest.append(currently_worn)
