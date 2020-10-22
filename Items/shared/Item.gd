extends Node2D

export(preload("res://Scripts/EquipmentManager.gd").TYPES) var type
export var item_name : String
export var texture : Texture
export(preload("res://Scripts/EquipmentManager.gd").RARITIES) var rarity
export var hp_modifier : int
export var speed_modifier : int
export var magic_modifier : int
export var damage_modifier : int
export var attack_speed_modifier : float
var player_nearby = false

func _process(delta):
	if player_nearby:
		if Input.is_action_just_pressed("ui_accept"):
			EquipmentManager.chest.append(duplicate())
			queue_free()

func _on_Item_body_entered(body):
	if body.name == "Player":
		player_nearby = true


func _on_Item_body_exited(body):
	if body.name == "Player":
		player_nearby = false
