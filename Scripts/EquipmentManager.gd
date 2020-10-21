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
	RARITIES.COMMON: [load("res://Items/Equipment/Chestplates/BaseChestplate.tscn").instance(), 
	load("res://Items/Equipment/Helmets/BaseHelmet.tscn").instance(),
	load("res://Items/Equipment/Boots/BaseBoots.tscn").instance(),
	load("res://Items/Equipment/Gloves/BaseGloves.tscn").instance(),
	load("res://Items/Equipment/Rings/BaseRing.tscn").instance(),
	load("res://Items/Equipment/Necklaces/BaseNecklace.tscn").instance()],
	RARITIES.UNCOMMON: [load("res://Items/Equipment/Chestplates/UpgradedChestplate.tscn").instance(), 
	load("res://Items/Equipment/Helmets/UpgradedHelmet.tscn").instance(),
	load("res://Items/Equipment/Boots/UpgradedBoots.tscn").instance(),
	load("res://Items/Equipment/Gloves/UpgradedGloves.tscn").instance(),
	load("res://Items/Equipment/Rings/GoldKnightRing.tscn").instance(),
	load("res://Items/Equipment/Necklaces/GoldKnightNecklace.tscn").instance()],
	RARITIES.RARE: [load("res://Items/Equipment/Helmets/CrusaderHelmet.tscn").instance(),
	load("res://Items/Equipment/Rings/BattlemageRing.tscn").instance()],
	RARITIES.EPIC: [load("res://Items/Equipment/Necklaces/MerlinsApprenticeNacklace.tscn").instance()],
	RARITIES.LEGENDARY: [load("res://Items/Equipment/Helmets/HelmetOfAvalonTears.tscn").instance()],
}

var chest = []


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
