extends Node
const _TAG = "DataImporter : "

var items = {}
var collections = {}
var recipes = {}

func _ready():
	print(_TAG + "Importing items from the data file...")
	var file = File.new()
	file.open("res://data/Items.json",File.READ)
	items = JSON.parse(file.get_as_text()).result
	file.close()
	print(_TAG, "Items imported!")
	print(_TAG, "Validating imported item data...")
	for key in items.keys():
		if items[key][Constants.ITEM_PATH] == Constants.ITEM_PATH_NOT_DEFINED:
			push_warning(_TAG + Constants.ITEM_PATH + " for " + items[key][Constants.ITEM_NAME] + " is " + Constants.ITEM_PATH_NOT_DEFINED)
		elif items[key][Constants.ITEM_PATH] != Constants.ITEM_PATH_NONE:
			if not file.file_exists(items[key][Constants.ITEM_PATH]):
				push_warning(_TAG + "Defined item path for " + items[key][Constants.ITEM_NAME] + " does not exist!")
			pass
		if items[key][Constants.ITEM_TEXTURE_PATH] == Constants.ITEM_PATH_NOT_DEFINED:
			push_warning(_TAG + Constants.ITEM_TEXTURE_PATH + " for " + items[key][Constants.ITEM_NAME] + " is " + Constants.ITEM_PATH_NOT_DEFINED)
		elif not file.file_exists(items[key][Constants.ITEM_TEXTURE_PATH]):
			push_warning(_TAG + "Defined texture path for the item " + items[key][Constants.ITEM_NAME] + " does not exist!")
	print(_TAG, "Validating finished!")
	
	print(_TAG + "Importing collections from the data file...")
	file.open("res://data/Collections.json", File.READ)
	collections = JSON.parse(file.get_as_text()).result
	file.close()
	print(_TAG, "Collections imported!")
	
	print(_TAG + "Importing recipes from the data file...")
	file.open("res://data/Recipes.json", File.READ)
	recipes = JSON.parse(file.get_as_text()).result
	file.close()
	print(_TAG, "Recipes imported!")

func get_items_from_collection(collection: String) -> Array:
	if not collections.has(collection): return []
	randomize()
	var selected_items = []
	var min_count = int(collections[collection][Constants.COLLECTION_MIN_ITEM_COUNT]) 
	var max_count = int(collections[collection][Constants.COLLECTION_MAX_ITEM_COUNT]) 
	var selected_count = randi() % ((max_count - min_count) + 1) + min_count
	while selected_count != 0:
		randomize()
		var rand = rand_range(0,1)
		for ind in range(1, 5):
			if collections[collection][Constants.COLLECTION_ITEM_CHANCE % ind] > rand:
				selected_items.push_back(collections[collection][Constants.COLLECTION_ITEM_NAME % ind])
				selected_count -= 1
				break;
	return selected_items

func get_random_item(search_limit_ms: int = 25) -> String:
	randomize()
	var keys = items.keys()
	var time_0 = search_limit_ms
	var last_selected = ""
	while time_0 > 0:
		var selector = randi() % keys.size()
		last_selected = keys[selector]
		randomize()
		if items[last_selected][Constants.ITEM_DROP_CHANCE] > rand_range(0,1):
			return keys[selector]
		time_0 -= 1
	return last_selected

func validate_item(item: String) -> bool: return items.has(item)
func validate_collection(collection: String)-> bool: return collections.has(collection)

func validate_recipe(items: Array) -> String:
	var items_dup = items.duplicate()
	for result in recipes.keys():
		if recipes[result][Constants.RECIPE_ITEM_COUNT] != items_dup.size(): continue
		items_dup.erase(recipes[result][Constants.RECIPE_ITEM_N % 1])
		items_dup.erase(recipes[result][Constants.RECIPE_ITEM_N % 2])
		items_dup.erase(recipes[result][Constants.RECIPE_ITEM_N % 3])
		if items_dup.empty(): return result
	return Constants.RECIPE_NF











