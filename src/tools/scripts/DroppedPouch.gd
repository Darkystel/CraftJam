extends Resource
class_name DroppedPouch

var items = []

signal pouch_emptied

func stash_items(items):
	for item in items:
		self.items.push_back(item)

func stash_item(item: Item):
	items.push_back(item)

func consume_item(item: Item) -> Item:
	if items.has(item):
		items.erase(item)
		if items.empty():
			emit_signal("pouch_emptied")
		return item
	else:
		return null