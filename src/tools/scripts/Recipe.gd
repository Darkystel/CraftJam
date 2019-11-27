extends Resource
class_name Recipe

export(Array, Resource) var items
export(Resource) var result

var all_items = []

func check_components(components) -> bool:
	print("Comparing components for '" + result.name + "'")
	
	if all_items.empty():
		var files = list_files_in_directory("res://src/tools/items_data/")
		for file in files:
			all_items.push_back(load("res://src/tools/items_data/" + file))
	
	var items_clone = items.duplicate()
	var items_loop = items_clone.duplicate()
	var components_clone = components.duplicate()
	var components_loop = components_clone.duplicate()
	
	if components_clone.size() != items_clone.size(): return false

	for component in components_loop:
		for item in items_loop:
			if component.name == item.name:
				components_clone.erase(component)
				items_clone.erase(item)
	
	if components_clone.empty() and items_clone.empty():
		return true
	return false

func find_item_by_name(items: Array, item: Item) -> int:
	for index in range(0, items.size()):
		if item.name == items[index].name:
			return index
	return -1

func list_files_in_directory(path): #TODO Move to global
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