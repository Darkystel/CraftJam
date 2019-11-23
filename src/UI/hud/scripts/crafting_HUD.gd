extends Control

var inventory = null

var recipe_list = []

var chosen_components = []
var result = null

onready var inventory_list = $VBoxContainer/inventory_panel/inventory_list
onready var crafting_list = $VBoxContainer/crafting_panel/crafting_list

func initialize(inventory):
	self.inventory = inventory

func _ready():
	assert(inventory == null)
	visible = false
	initialize_recipes()

func initialize_recipes():
	var file_paths = list_files_in_directory("res://src/tools/recipe_data")
	for path in file_paths:
		var recipe = load("res://src/tools/recipe_data/" + path)
		recipe_list.append(recipe)



func _unhandled_input(event):
	if event.is_action_pressed("crafting_hud"):
		if get_tree().paused:
			inventory_list.clear()
			visible = false
			get_tree().paused = false
		else:
			display_items()
			visible = true
			get_tree().paused = true

func display_items():
	for item in inventory.items:
		inventory_list.add_icon_item(item.item_texture)

func _on_inventory_list_item_activated(index):
	var selected_item = inventory.items[index]
	if not chosen_components.has(selected_item):
		chosen_components.push_back(selected_item)
		crafting_list.add_icon_item(selected_item.item_texture)


func _on_craft_pressed():
	if find_recipe():
		crafting_list.clear()
		for component in chosen_components:
			inventory.erase(component)
		inventory_list.clear()
		inventory.add_to_inventory(result)
		display_items()


func find_recipe() -> bool:
	print("find_recipe() called")
	for recipe in recipe_list:
		print("checking in recipe for '" + recipe.result.name + "'")
		if recipe.check_components(chosen_components):
			result = recipe.result
			return true
	return false
	

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

