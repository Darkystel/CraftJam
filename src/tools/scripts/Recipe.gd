extends Resource
class_name Recipe

export(Array, Resource) var items
export(Resource) var result

func check_components(components) -> bool:
	print("Comparing components for '" + result.name + "'")
	
	var items_clone = items
	
	if components.size() != items.size(): return false
	
	while true:
		if items.size() == 0 and components.size() == 0: return true
		elif items.has(components[0]):
			items.erase(components[0])
			components.pop_front()
		else: return false
	return false