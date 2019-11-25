extends Panel

func update_item(item: Item, disable_drop: bool = false, disable_equip: bool = false):
	$item_texture.texture = item.item_texture
	$item_name.text = item.name
	$item_description.text = item.description
	$drop.disabled = disable_drop
	$equip.disabled = disable_equip

func clear():
	$item_texture.texture = null
	$item_name.text = ""
	$item_description.text = ""
	$drop.disabled = true
	$equip.disabled = true