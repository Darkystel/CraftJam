extends Resource
class_name Inventory

export(int) var capacity = 4
export(int) var equip_capacity = 4

var items = []
var craft = []
var hot_equip = []
var recipe_list = []

var available_capacity: int setget , get_available_capacity
func get_available_capacity() -> int: return capacity - items.size()

signal inventory_changed
# This script will handle the inventory system of the player character

func add_to_inventory(item) -> bool:
	if items.size() < capacity:
		items.push_back(item)
		emit_signal("inventory_changed")
		return true
	else: return false

func put_in_hot_equip(item) -> bool:
	if items.has(item):
		hot_equip.push_back(consume_item(item))
		return true
	else:
		return false

func consume_item(item: Item) -> Item:
	if items.has(item):
		items.erase(item)
		emit_signal("inventory_changed")
		return item
	return null

func consume_craft(item: Item) -> Item:
	if craft.has(item):
		craft.erase(item)
		emit_signal("inventory_changed")
		return item
	return null

func consume_hot_equip(item: Item) -> Item:
	if hot_equip.has(item):
		hot_equip.erase(item)
		return item
	else:
		return null

func add_to_craft(item) -> bool:
	if items.has(item):
		craft.push_back(consume_item(item))
		return true
	else:
		return false

func remove_from_craft(item) -> bool:
	if craft.has(item):
		items.push_back(consume_craft(item))
		return true
	else:
		return false

func return_all_from_craft() -> bool:
	for item in craft:
		items.push_back(item)
	craft.clear()
	if craft.empty():
		return true
	else:
		return false

func equip_item(item: Item) -> bool:
	if items.has(item) and item.is_equippable() and hot_equip.size() < equip_capacity:
		hot_equip.push_back(consume_item(item))
		return true
	else:
		return false

func unequip_item(item: Item) -> bool:
	if hot_equip.has(item) and items.size() < capacity:
		items.push_back(consume_hot_equip(item))
		return true
	else:
		return false

func try_crafting() -> Message:
	var msg = Message.new()
	msg.title = "Crafting Information"
	if craft.empty():
		msg.description = "No items to craft"
	else:
		for recipe in recipe_list:
			if recipe.check_components(craft):
				add_to_inventory(recipe.result)
				craft.clear()
				msg.description = str(recipe.result.name) + " Crafted!"
				msg.success = true
				msg.additional_info["result-item"] = recipe.result
				return msg
		msg.description = "Those components do not mix up!"
	msg.success = false
	return msg

func initialize_recipes():
	print('before initialization = ' + str(recipe_list))
	var file_paths = list_files_in_directory("res://src/tools/recipe_data")
	for path in file_paths:
		var recipe = load("res://src/tools/recipe_data/" + path)
		recipe_list.append(recipe)
	print('after initialization = ' + str(recipe_list))

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	dir.list_dir_end()
	return files