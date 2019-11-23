extends Panel

func initialize_inventory(inventory):
	var x_offset = 16*inventory.capacity/2
	rect_position.x = (get_viewport_rect().size.x/2) - x_offset
	rect_size.x = 16*inventory.capacity
	var item = load("res://src/UI/hud/item.tscn")
	for index in range(0, inventory.capacity):
		var item_ins = item.instance()
		add_child(item_ins)
		if index < inventory.items.size():
			item_ins.set_texture(inventory.items[index].item_texture)
		item_ins.rect_position.x = index * 16

func update_inventory(inventory):
	for item_index in inventory.items.size():
		get_children()[item_index].set_texture(inventory.items[item_index].item_texture)