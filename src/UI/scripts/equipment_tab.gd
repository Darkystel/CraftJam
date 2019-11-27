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
	if get_inventory().equip_item(item):
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

func _on_charge_pressed():
	selected_item.emit_signal("charge")
	get_inventory().consume_charger()
	update_lists()

func _on_inventory_list_item_selected(index):
	selected_item = get_inventory().items[index]
	hot_equip_list.unselect_all()
	$charge.disabled = (not selected_item.is_chargable() and not get_inventory().has_charger) or not selected_item.is_chargable()


func _on_hot_equip_list_item_selected(index):
	selected_item = get_inventory().hot_equip[index]
	inventory_list.unselect_all()
	$charge.disabled = not selected_item.is_chargable() and not get_inventory().has_charger
	