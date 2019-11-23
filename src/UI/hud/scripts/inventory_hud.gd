extends Panel

signal item_clicked(item,index)

func initialize_inventory(inventory, center_viewport: bool = true):
	if center_viewport:
		var x_offset = 16*inventory.capacity/2
		rect_position.x = (get_viewport_rect().size.x/2) - x_offset
	rect_size.x = 16*inventory.capacity
	var item = load("res://src/UI/hud/item.tscn")
	for index in range(0, inventory.capacity):
		var item_ins = item.instance()
		add_child(item_ins)
		item_ins.initialize(inventory, index)
		item_ins.rect_position.x = index * 16
		item_ins.connect("item_pressed", self, "item_click")

func item_click(item, index):
	emit_signal("item_clicked", item, index)