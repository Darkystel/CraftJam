extends Panel

func update_item(item: String):
	$Panel2/item_name.text = item
	$Panel/item_texture.texture = load(DataImporter.items[item][Constants.ITEM_TEXTURE_PATH])
	$Panel3/item_description.text = DataImporter.items[item][Constants.ITEM_DESCRIPTION]