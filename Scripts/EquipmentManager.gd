extends Node

var Item = load("res://Items/shared/Item.tscn")

enum TYPES {
	SWORD, 
	AXE, 
	SPEAR, 
	CHESTPLATE, 
	HELMET, 
	GLOVES, 
	BOOTS, 
	RING,
	NECKLACE
}

enum RARITIES {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY
}

const RARITY_COLORS = {
	RARITIES.COMMON: Color.white,
	RARITIES.UNCOMMON: Color.limegreen,
	RARITIES.RARE: Color.blue,
	RARITIES.EPIC: Color.purple,
	RARITIES.LEGENDARY: Color.orange
}

var items= {
	RARITIES.COMMON: [load("res://Items/Equipment/BaseChestplate.tscn").instance(), 
	load("res://Items/Equipment/BaseHelmet.tscn").instance(),
	load("res://Items/Equipment/BaseBoots.tscn").instance(),
	load("res://Items/Equipment/BaseGloves.tscn").instance(),
	load("res://Items/Equipment/BaseRing.tscn").instance(),
	load("res://Items/Equipment/BaseNecklace.tscn").instance()],
	RARITIES.RARE: [load("res://Items/Equipment/CrusaderHelmet.tscn").instance()],
}

var chest = items[RARITIES.COMMON]

var worn_items = {
	"Sword": load("res://Items/Weapons/Swords/BaseSword.tscn").instance(),
	"Axe": null,
	"Spear": null, 
	"Chestplate": null, 
	"Helmet": null, 
	"Gloves": null, 
	"Boots": null, 
	"Ring": null,
	"Necklace": null
}
