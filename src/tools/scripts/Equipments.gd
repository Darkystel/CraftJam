extends Node2D

var currently_equipped: Item

func equip(item: Item):
	if item != currently_equipped:
		currently_equipped = item
		currently_equipped.connect("charge", self, "charge_equipment")
		var item_scene = item.item_scene.instance()
		add_child(item_scene)
	else:
		print('Item already equipped')

func charge_equipment():
	get_child(get_child_count()-1).charge_battery()

func unequip():
	var stored_state = get_child(get_child_count()-1).unequip()
	currently_equipped.stored_state = stored_state
	get_child(get_child_count()-1).queue_free()