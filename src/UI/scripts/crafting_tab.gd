extends IMTabs

######################################
onready var inventory_list = $Panel/inventory_list
onready var crafting_list = $Panel/craft_list
onready var crafting_message = $Panel2/craft_message
######################################

func update_lists():
	inventory_list.clear()
	crafting_list.clear()
	for item in get_inventory().items:
		inventory_list.add_icon_item(item.item_texture)
	for item in get_inventory().craft:
		crafting_list.add_icon_item(item.item_texture)

func _on_inventory_list_item_activated(index):
	get_inventory().add_to_craft(get_inventory().items[index])
	update_lists()


func _on_craft_list_item_activated(index):
	get_inventory().remove_from_craft(get_inventory().craft[index])
	update_lists()

func _on_craft_pressed():
	var message = get_inventory().try_crafting()
	if message.success:
		update_lists()
	else:
		get_inventory().return_all_from_craft()
		update_lists()
	crafting_message.text = message.description

func _on_reset_pressed():
	get_inventory().return_all_from_craft()
	update_lists()

func _on_tabs_tab_changed(tab):
	if tab == 1:
		update_lists()
	else:
		crafting_message.text = ""
		get_inventory().return_all_from_craft()

func flush_leftovers():
	get_inventory().return_all_from_craft()