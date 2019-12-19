extends IMTabs

var crafting = []

onready var items_list = $items_list
onready var crafting_list = $crafting_list
onready var item_count = $item_count


func _update_interface():
	items_list.clear()
	for item in get_inventory().items:
		var item_texture = load(DataImporter.items[item][Constants.ITEM_TEXTURE_PATH])
		items_list.add_item(item, item_texture)
	crafting_list.clear()
	for item in crafting:
		var item_texture = load(DataImporter.items[item][Constants.ITEM_TEXTURE_PATH])
		crafting_list.add_icon_item(item_texture)
	item_count.text = "%d/4" %crafting.size()

func _on_items_list_item_activated(index):
	if crafting.size() < 4:
		crafting.push_back(get_inventory().take_item(get_inventory().items[index]))
		_update_interface()

func _on_TabContainer_tab_changed(tab):
	_update_interface()

