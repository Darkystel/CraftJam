extends Resource
class_name Item

enum types {
	CRAFTABLE,
	USABLE,
	
	}

export(String) var name = ""
export(String, MULTILINE) var description = ""
export(types) var type = types.USABLE
export(Texture) var item_texture = null

var stack_count = 0
var craft_count = 0