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
	RARITIES.COMMON: [load("res://Items/Equipment/Chestplates/BaseChestplate.tscn"), 
	load("res://Items/Equipment/Helmets/BaseHelmet.tscn"),
	load("res://Items/Equipment/Boots/BaseBoots.tscn"),
	load("res://Items/Equipment/Gloves/BaseGloves.tscn"),
	load("res://Items/Equipment/Rings/BaseRing.tscn"),
	load("res://Items/Equipment/Necklaces/BaseNecklace.tscn")],
	RARITIES.UNCOMMON: [load("res://Items/Equipment/Chestplates/UpgradedChestplate.tscn"), 
	load("res://Items/Equipment/Helmets/UpgradedHelmet.tscn"),
	load("res://Items/Equipment/Boots/UpgradedBoots.tscn"),
	load("res://Items/Equipment/Gloves/UpgradedGloves.tscn"),
	load("res://Items/Equipment/Rings/GoldKnightRing.tscn"),
	load("res://Items/Equipment/Necklaces/GoldKnightNecklace.tscn")],
	RARITIES.RARE: [load("res://Items/Equipment/Helmets/CrusaderHelmet.tscn"),
	load("res://Items/Equipment/Rings/BattlemageRing.tscn")],
	RARITIES.EPIC: [load("res://Items/Equipment/Necklaces/MerlinsApprenticeNacklace.tscn")],
	RARITIES.LEGENDARY: [load("res://Items/Equipment/Helmets/HelmetOfAvalonTears.tscn")],
}

var chest = [items[RARITIES.COMMON][0].instance()]

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
