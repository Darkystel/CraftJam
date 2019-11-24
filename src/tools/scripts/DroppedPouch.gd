extends Resource
class_name DroppedPouch

var items = []

func stash_items(items):
	for item in items:
		self.items.push_back(item)