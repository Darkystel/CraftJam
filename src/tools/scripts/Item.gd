extends Resource
class_name Item

enum types_enum {
	COMPONENT,
	USABLE,
	EQUIPPABLE,
	THROWABLE,
	DROPPABLE,
	CHARGABLE
	}

export(String) var name = ""
export(String, MULTILINE) var description = ""
export(Array, types_enum) var types
export(Texture) var item_texture = null
export(PackedScene) var item_scene
export(float,0.0,0.5) var battery_drain = 0.12

var stored_state = {}

signal charge
signal unequip

func is_equippable() -> bool: return types.has(types_enum.EQUIPPABLE)
func is_chargable() -> bool: return types.has(types_enum.CHARGABLE)