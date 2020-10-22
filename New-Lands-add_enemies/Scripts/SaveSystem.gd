extends Node

var autosave = Timer.new()

var equipped_items = {
	"Sword": null,
	"Axe": null,
	"Spear": null, 
	"Chestplate": null, 
	"Helmet": null, 
	"Gloves": null, 
	"Boots": null, 
	"Ring": null,
	"Necklace": null
}

func _ready():
	load_worn_items()
	load_chest()
	
	autosave.wait_time = 1
	autosave.connect("timeout",self,"save_worn_items")
	autosave.connect("timeout",self,"save_chest")
	add_child(autosave)
	autosave.start()
	
	
	
func save_worn_items():
	for item in EquipmentManager.worn_items:
		if(EquipmentManager.worn_items[item] != null):
			equipped_items[item] = EquipmentManager.worn_items[item].filename
		
	var file = File.new()
	if file.open("res://Save/worn_items.json", File.WRITE) != 0:
		print("Error opening file")
		return

	file.store_line(to_json(equipped_items))
	file.close()
	
func save_chest():
	var file = File.new()
	if file.open("res://Save/chest_items", File.WRITE) != 0:
		print("Error opening file")
		return

	for item in EquipmentManager.chest:
		file.store_line(item.filename)
	file.close()
	
func load_worn_items():
	var file = File.new()
	if file.open("res://Save/worn_items.json", File.READ) != 0:
		print("Error opening file")
		return

	var data = {}
	data = parse_json(file.get_line())
	
	for item in EquipmentManager.worn_items:
		if(data[item] != null):
			EquipmentManager.worn_items[item] = load(str(data[item])).instance()
	
	file.close()
	

func load_chest():
	EquipmentManager.chest.clear()
	var file = File.new()
	if file.open("res://Save/chest_items", File.READ) != 0:
		print("Error opening file")
		return

	var data = []
	var index = 0
	
	while not file.eof_reached():
		data.append(file.get_line())
		
	for i in range(data.size()):
		if(str(data[i]) != ""):
			EquipmentManager.chest.append(load(str(data[i])).instance())
		
	file.close()
