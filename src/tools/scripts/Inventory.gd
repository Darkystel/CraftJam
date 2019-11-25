extends Resource
class_name Inventory

export(int) var capacity = 8

var items = []
var craft = []
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

func consume_item(item) -> Item:
	if items.has(item):
		items.erase(item)
		emit_signal("inventory_changed")
		return item
	return null

func add_to_craft(item) -> bool:
	if items.has(item):
		craft.push_back(consume_item(item))
		return true
	else:
		return false

func consume_craft(item) -> Item:
	if craft.has(item):
		craft.erase(item)
		emit_signal("inventory_changed")
		return item
	return null

func remove_from_craft(item) -> bool:
	if craft.has(item):
		items.push_back(consume_craft(item))
		return true
	else:
		return false

func return_all_from_craft():
	for item in craft:
		remove_from_craft(item)

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