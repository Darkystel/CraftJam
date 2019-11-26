extends Node2D

var index_mapping = -1

func equip(item: Item, index: int):
	if index_mapping == -1 or index_mapping != index:
		var item_scene = item.item_scene.instance()
		add_child(item_scene)
		index_mapping = index
