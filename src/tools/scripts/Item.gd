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
export(Dictionary) var additional_item_info = {
	"battery_drain": 0.12,
	}
var scene_params = {}
signal unequip

func charge_item() -> Message:
	var msg = Message.new()
	msg.title = "Charging Info"
	if not is_chargable():
		msg.success = false
		msg.description = "Item is not chargable"
		return msg
	if scene_params.has('battery'):
		if scene_params['battery'] < 60.0:
			scene_params['battery'] = 100.0
			msg.success = true
			msg.description = "Battery recharged"
			return msg
		else:
			msg.success = false
			msg.description = "Hmm, overloading the battery with this charger might blow it"
			return msg
	else:
		msg.success = false
		msg.description = "Uhh, why would I charge an unused device?"
		return msg

func is_equippable() -> bool: return types.has(types_enum.EQUIPPABLE)
func is_chargable() -> bool:
	print('CHARGABLE = ' + str(types_enum.CHARGABLE))
	print('current types = ' + str(types))
	return types.has(types_enum.CHARGABLE)