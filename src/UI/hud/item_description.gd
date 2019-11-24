extends Panel

func update_item(item: Item):
	$item_texture.texture = item.item_texture
	$item_name.text = item.name
	$item_description.text = item.description