extends Resource
class_name Inventory

export(int) var capacity = 8

var items = []
var crafting_components = []
var recipe_list = []

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
		return item
	return null

func consume_crafting_component(item) -> Item:
	if crafting_components.has(item):
		crafting_components.erase(item)
		return item
	return null

func consume_crafting_components():
	crafting_components.clear()

func put_in_crafting(item: Item):
	var item_to_move = consume_item(item)
	if item_to_move != null:
		crafting_components.push_back(item)

func put_back_in_items(item: Item):
	var item_to_move = consume_crafting_component(item)
	if item_to_move != null:
		items.push_back(item)

func try_crafting() -> Message:
	var msg = Message.new()
	msg.title = "Crafting Information"
	for recipe in recipe_list:
		if recipe.check_components(crafting_components):
			add_to_inventory(recipe.result)
			consume_crafting_components()
			msg.description = str(recipe.result.name) + " Crafted!"
			msg.success = true
			return msg
	
	msg.description = "Those components don't mix up!"
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