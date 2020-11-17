extends Label

"""
Tooltip showing stats of an item in inventory
It contains its own timer, so all the code is self-contained
Needs a variable item in parent, where Item is stored
@TODO Convert it into dependency injection
"""

onready var parent = get_parent()

func _ready():
	parent.connect("mouse_entered", self, "_on_parent_mouse_entered")
	parent.connect("mouse_exited", self, "_on_parent_mouse_exited")

func _on_parent_mouse_entered():
	$Timer.start(1)

func _on_parent_mouse_exited():
	$Timer.stop()
	visible = false

func _on_Timer_timeout():
	# Construct the tootip text, if that item wasn't shown before
	# Game very rarely crashes stating that parent.item is null
	# I could not reproduce this problem on purpose and I suspect it's some race condition, so I decided to put this null check here
	if text == "" and parent.item != null:
		var item = parent.item
		# Check if item is a Weapon
		# This is necessary in order to properly show weapon-specific stats
		# From my tests, this preloading doesn't actually increase memory usag, probably due to some engine caching
		if item is preload("res://Items/Weapons/shared/Weapon.gd"):
			text += "Damage: " + str(item.damage) + "\n"
			text += "Attack speed: " + str(item.attack_speed) + "\n"
			text += "Attack width: " + str(item.attack_width) + "\n"
			text += "Attack range: " + str(item.attack_range) + "\n"
		# Only show modifiers if they are bigger than 0, to not clutter the tooltip
		if item.hp_modifier != 0:
			text += "Health bonus: " + str(item.hp_modifier) + "\n"
		if item.speed_modifier != 0:
			text += "Speed bonus: " + str(item.speed_modifier) + "\n"
		if item.magic_modifier != 0:
			text += "Magic bonus: " + str(item.magic_modifier) + "\n"
		if item.damage_modifier != 0:
			text += "Damage bonus: " + str(item.damage_modifier) + "\n"
		if item.attack_speed_modifier != 0:
			text += "Attack speed bonus: " + str(item.attack_speed_modifier) + "\n"
		# Delete last newline character to avoid label background being bigger than actual text show
		text = text.rstrip("\n")
	visible = true
