extends IMTabs

#####################################
var selected_item: Item
var items_to_drop = []
var items_to_equip = []
#####################################
onready var inventory_list = $HBoxContainer/inventory_list
onready var item_info = $HBoxContainer/item_info
#####################################

func _ready():
	update_inventory_list()

func update_inventory_list():
	inventory_list.clear()
	for item in get_inventory().items:
		inventory_list.add_icon_item(item.item_texture)

func _on_inventory_list_item_selected(index): #Display item info
	selected_item = get_inventory().items[index]
	var equippable = selected_item.types.has(selected_item.types_enum.EQUIPPABLE)
	item_info.update_item(selected_item, false, not equippable)

func _on_drop_pressed():
	if selected_item != null:
		items_to_drop.push_back(get_inventory().consume_item(selected_item))
		update_inventory_list()

func _on_equip_pressed():
	if selected_item != null:
		get_inventory().put_in_hot_equip(selected_item)
		update_inventory_list()

func flush_leftovers():
	var flush_info = UIFlushInfo.new()
	var pouch = DroppedPouch.new()
	pouch.items = items_to_drop.duplicate()
	items_to_drop.clear()
	flush_info.dropped_pouch = pouch
	return flush_info

func _on_tabs_tab_changed(tab):
	if tab == 0:
		update_inventory_list()
