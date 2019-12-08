extends Node
const _TAG = "PlayerInventory : "

export(int) var capacity = 6

var items = []

#####################################
#              CONSTANTS            #
#####################################
const _CAPACITY = "CAP"
const _ITEMS = "ITMS"
#####################################

#####################################
#          MODIFYING METHODS        #
#####################################
func add_item(item: String):
	if items.size() < capacity:
		items.push_back(item)
		print(_TAG, "Item [" + item + "] was added to inventory.")
		return true
	else:
		print(_TAG, "Inventory full.")
		return false
func take_item(item: String) -> String:
	if items.has(item):
		items.erase(item)
		return item
	else:
		return ""
#####################################

#####################################
#         DATA SAVER/LOADER         #
#####################################
func _save() -> Dictionary:
	return {
		_CAPACITY: capacity,
		_ITEMS: items
	}
func _load(data: Dictionary):
	if data.has(_CAPACITY): capacity = int(data[_CAPACITY])
	else: push_error(_TAG + "Failed to load " + _CAPACITY + " data from the passed data dictionary.")
	if data.has(_ITEMS): items = data[_ITEMS]
	else: push_error(_TAG + "Failed to load " + _ITEMS + " data from the passed data dictionary.")
#####################################