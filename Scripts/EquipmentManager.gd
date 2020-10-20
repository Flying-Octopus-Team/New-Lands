extends Node

var Item = load("res://Items/shared/Item.tscn")

enum TYPES {
	SWORD, 
	AXE, 
	SPEAR, 
	CHESTPLATE, 
	HELMET, 
	LEGGINGS, 
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

var chest = [load("res://Items/Weapons/Swords/BaseSword.tscn").instance(),
			load("res://Items/Weapons/Swords/RareAxe.tscn").instance(),
			load("res://Items/Weapons/Swords/LegendaryAxe.tscn").instance()]

var worn_items = {
	"Sword": null,
	"Axe": null,
	"Spear": null, 
	"Chestplate": null, 
	"Helmet": null, 
	"Leggings": null, 
	"Boots": null, 
	"Ring": null,
	"Necklace": null
}
