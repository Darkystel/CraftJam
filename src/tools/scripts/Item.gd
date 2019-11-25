extends Resource
class_name Item

enum types_enum {
	COMPONENT,
	USABLE,
	EQUIPPABLE,
	THROWABLE,
	DROPPABLE
	}

export(String) var name = ""
export(String, MULTILINE) var description = ""
export(Array, types_enum) var types
export(Texture) var item_texture = null
export(PackedScene) var item_scene

var stack_count = 0
var craft_count = 0