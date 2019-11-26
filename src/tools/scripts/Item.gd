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

func is_equippable() -> bool: return types.has(types_enum.EQUIPPABLE)