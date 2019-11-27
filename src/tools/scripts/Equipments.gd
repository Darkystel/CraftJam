extends Node2D

var currently_equipped: Item

func equip(item: Item):
	if item != currently_equipped:
		currently_equipped = item
		currently_equipped.connect("unequip", self, "unequip")
		var item_scene = item.item_scene.instance()
		item_scene.item_resource = currently_equipped
		add_child(item_scene)
	elif item != null:
		unequip()
		currently_equipped = item
		currently_equipped.connect("unequip", self, "unequip")
		var item_scene = item.item_scene.instance()
		item_scene.item_resource = currently_equipped
		add_child(item_scene)
	else:
		unequip()

func unequip():
	get_child(get_child_count()-1).queue_free()
	currently_equipped.disconnect("unequip", self, "unequip")
	currently_equipped = null