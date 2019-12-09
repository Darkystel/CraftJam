extends IMTabs

#####################################
var selected_item
#####################################
onready var item_list = $item_list
onready var item_description = $item_description
#####################################

func _ready():
	update_inventory_list()

func update_inventory_list():
	item_list.clear()
	for item in get_inventory().items:
		var item_texture = load(DataImporter.items[item][Constants.ITEM_TEXTURE_PATH])
		item_list.add_item(item, item_texture)

func _on_inventory_list_item_selected(index): #Display item info
	selected_item = get_inventory().items[index]
	item_description.update_item(selected_item)

func flush_leftovers():
	pass

func _on_tabs_tab_changed(tab):
	if tab == 0:
		if get_inventory().return_all_from_craft():
			update_inventory_list()