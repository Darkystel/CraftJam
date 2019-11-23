extends Resource
class_name Inventory

export(int) var capacity = 8

var items = []
# This script will handle the inventory system of the player character

func add_to_inventory(item) -> bool:
	if items.size() < capacity:
		items.push_back(item)
		return true
	else: return false