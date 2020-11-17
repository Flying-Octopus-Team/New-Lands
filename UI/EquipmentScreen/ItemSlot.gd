extends Panel

"""
Graphical representation of an inventory slot.
Shows an item worn by the player (or an empty slot).
"""

export(preload("res://Scripts/EquipmentManager.gd").TYPES) var type
var item

func _ready():
	$VBoxContainer/Name.text = EquipmentManager.TYPES.keys()[type].capitalize()
