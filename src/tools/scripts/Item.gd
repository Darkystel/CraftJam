extends Resource
class_name Item

enum types {
	CRAFTABLE,
	USABLE,
	
	}

export(String) var name = "No Name.png"
export(types) var type = types.USABLE
export(Texture) var item_texture = null