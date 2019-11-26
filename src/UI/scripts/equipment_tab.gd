extends IMTabs

var selected_item: Item
######################################
onready var character = $character
onready var description = $description
onready var inventory_list = $inventory_list
onready var hot_equip_list = $hot_equip_list
######################################

func _ready():
	update_lists()

func update_lists():
	inventory_list.clear()
	hot_equip_list.clear()
	for item in get_inventory().items:
		inventory_list.add_icon_item(item.item_texture)
	for equipped_item in get_inventory().hot_equip:
		hot_equip_list.add_icon_item(equipped_item.item_texture)

func _on_inventory_list_item_activated(index):
	var item = get_inventory().items[index]
	if get_inventory().equip_item(get_inventory().items[index]):
		character.frame = 0
		update_lists()
		description.text = item.name + " equipped!"
	else:
		description.text = "Can not equip " + item.name

func _on_hot_equip_list_item_activated(index):
	var item = get_inventory().hot_equip[index]
	if get_inventory().unequip_item(get_inventory().hot_equip[index]):
		character.frame = 0
		update_lists()
		description.text = item.name + " unequipped!"
	else:
		description.text = "Not enough space in inventory"

func _on_tabs_tab_changed(tab):
	if tab == 2:
		update_lists()