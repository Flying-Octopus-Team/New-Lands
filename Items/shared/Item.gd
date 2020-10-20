extends Node2D

export(preload("res://Scripts/EquipmentManager.gd").TYPES) var type
export var item_name : String
export var texture : Texture
export(preload("res://Scripts/EquipmentManager.gd").RARITIES) var rarity
export var hp_modifier : int
export var speed_modifier : int
export var magic_modifier : int
export var damage_modifier : int
export var attack_speed_modifier : int
