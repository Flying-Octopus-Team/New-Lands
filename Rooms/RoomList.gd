"""
This file stores a list of all room variants used to generate map
Format: {
	room type: {
		shape: array of preloaded room variants
	}
}
"""
var rooms = {
	# Empty rooms and rooms with small figths
	"small": {
		"EN": [preload("res://Rooms/Small/EN/Small_en1.tscn"),
		preload("res://Rooms/Small/EN/Small_en2.tscn")],
		"ES": [preload("res://Rooms/Small/ES/Small_es1.tscn"), 
		preload("res://Rooms/Small/ES/Small_es2.tscn")],
		"EW": [preload("res://Rooms/Small/EW/Small_ew1.tscn"), 
		preload("res://Rooms/Small/EW/Small_ew2.tscn")],
		"NS": [preload("res://Rooms/Small/NS/Small_ns1.tscn"), 
		preload("res://Rooms/Small/NS/Small_ns2.tscn")],
		"NW": [preload("res://Rooms/Small/NW/Small_nw1.tscn"), 
		preload("res://Rooms/Small/NW/Small_nw2.tscn")],
		"SW": [preload("res://Rooms/Small/SW/Small_sw1.tscn"), 
		preload("res://Rooms/Small/SW/Small_sw2.tscn")]
	},
	# Rooms with medium and large fights
	"large": {
		"EN": [preload("res://Rooms/Large/EN/Large_en1.tscn"), 
		preload("res://Rooms/Large/EN/Large_en2.tscn")],
		"ES": [preload("res://Rooms/Large/ES/Large_es1.tscn"), 
		preload("res://Rooms/Large/ES/Large_es2.tscn")],
		"EW": [preload("res://Rooms/Large/EW/Large_ew1.tscn"), 
		preload("res://Rooms/Large/EW/Large_ew2.tscn")],
		"NS": [preload("res://Rooms/Large/NS/Large_ns1.tscn"), 
		preload("res://Rooms/Large/NS/Large_ns2.tscn")],
		"NW": [preload("res://Rooms/Large/NW/Large_nw1.tscn"), 
		preload("res://Rooms/Large/NW/Large_nw2.tscn")],
		"SW": [preload("res://Rooms/Large/SW/Large_sw1.tscn"), 
		preload("res://Rooms/Large/SW/Large_sw2.tscn")]
	},
	# First rooms of any level
	"entrance": {
		"N": [preload("res://Rooms/Entrance/N/Entrance_n1.tscn"), 
		preload("res://Rooms/Entrance/N/Entrance_n2.tscn")],
		"E": [preload("res://Rooms/Entrance/E/Entrance_e1.tscn"), 
		preload("res://Rooms/Entrance/E/Entrance_e2.tscn")],
		"W": [preload("res://Rooms/Entrance/W/Entrance_w1.tscn"), 
		preload("res://Rooms/Entrance/W/Entrance_w2.tscn")]
	},
	# Boss rooms
	"boss": {
		"S": [preload("res://Rooms/Boss/S/Boss_s1.tscn"), 
		preload("res://Rooms/Boss/S/Boss_s2.tscn")],
		"E": [preload("res://Rooms/Boss/E/Boss_e1.tscn"), 
		preload("res://Rooms/Boss/E/Boss_e2.tscn")],
		"W": [preload("res://Rooms/Boss/W/Boss_w1.tscn"), 
		preload("res://Rooms/Boss/W/Boss_w2.tscn")]
	},
}

