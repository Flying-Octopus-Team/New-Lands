extends CanvasLayer

"""
This node is the UI of the equipment screen.
Its role is managing the presentation of chest and inventory
"""

onready var chest = $HBoxContainer/Chest/Chest/ScrollContainer/MarginContainer/GridContainer
onready var slots = $HBoxContainer/Equipment/Equipment/CenterContainer/GridContainer
var Thumbnail = preload("res://UI/EquipmentScreen/ItemThumbnail.tscn")

func _ready():
	for item in EquipmentManager.chest:
		add_thumbnail(item)
	for slot in EquipmentManager.worn_items.keys():
		var item = EquipmentManager.worn_items[slot]
		slots.get_node(slot).item = item
		if item != null:
			slots.get_node(slot).get_node("VBoxContainer/Texture/Texture").texture = item.texture


func _on_thumbnail_double_clicked(item):
	var slot = slots.get_node(EquipmentManager.TYPES.keys()[item.type].capitalize())
	if slot.item != null:
		add_thumbnail(slot.item)
	slot.get_node("VBoxContainer/Texture/Texture").texture = item.texture
	slot.item = item
	
	
func add_thumbnail(item):
	var thumbnail = Thumbnail.instance()
	thumbnail.item = item
	thumbnail.connect("thumbnail_double_click", self, "_on_thumbnail_double_clicked")
	thumbnail.connect("thumbnail_double_click", get_parent(), "_on_thumbnail_double_clicked")
	chest.add_child(thumbnail)
