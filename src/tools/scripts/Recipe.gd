extends Resource
class_name Recipe

export(Array, Resource) var items
export(Resource) var result

func check_components(components) -> bool:
	print("Comparing components for '" + result.name + "'")
	
	var items_clone = items.duplicate()
	var components_clone = components.duplicate()
	
	if components_clone.size() != items_clone.size(): return false
	
	while true:
		if items_clone.size() == 0 and components_clone.size() == 0: return true
		elif items_clone.has(components_clone[0]):
			items_clone.erase(components_clone[0])
			components_clone.pop_front()
		else: return false
	return false