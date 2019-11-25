extends Control

var inventory: Inventory

func initialize(inventory: Inventory):
	self.inventory = inventory
	inventory.connect("inventory_changed",self,"inventory_changed")
	update_items()

func update_items():
	var item_buttons = $inventory.get_children()
	for index in range(0, inventory.fast_equip_items.size()):
		item_buttons[index].pass_item(inventory.fast_equip_items[index])

func _unhandled_input(event):
	if event.is_action_pressed("fast_equip"):
		visible = not visible

func _on_item_pressed(item):
	print(item.name)

func inventory_changed():
	print("inventory changed")
	update_items()