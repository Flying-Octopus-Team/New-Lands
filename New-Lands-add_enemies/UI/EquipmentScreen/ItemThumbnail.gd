extends Panel

"""
Singular item shown in the chest. 
This is only a graphical representation, actual item is stored in EquipmentManager
"""

signal thumbnail_double_click(item)

var item

func _ready():
	$Thumbnail/Texture/Texture.texture = item.texture
	$Thumbnail/Name.text = item.item_name
	$Thumbnail/Name.set("custom_colors/font_color", EquipmentManager.RARITY_COLORS[item.rarity])


# Send a signal telling other nodes to equip this item and then delete itself from chest
func _on_ItemThumbnail_gui_input(event):
	if event is InputEventMouseButton and event.doubleclick:
		emit_signal("thumbnail_double_click", item)
		queue_free()
