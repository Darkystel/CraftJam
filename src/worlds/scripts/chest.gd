extends Area2D
const _TAG = "Chest : "

export(String) var collection

var items = []
var player = null

onready var overlay = $CanvasLayer/overlay
onready var item_list = $CanvasLayer/overlay/container/items_list

func _ready():
	if not DataImporter.validate_collection(collection):
		push_warning(_TAG + "In node " + self.name + ", parent " + get_parent().name + ", collection name does not exist.")
		print(_TAG + "Will not render due to validation failure.")
		visible = false
	else:
		items = DataImporter.get_items_from_collection(collection)
		_update_interface()

func _unhandled_input(event):
	if event.is_action_pressed("interact") and player != null:
		toggle_pause_all_but_this()
		overlay.visible = not overlay.visible
	if event.is_action_pressed("escape") and overlay.visible:
		toggle_pause_all_but_this()
		overlay.visible = false

#####################################
#         INTERFACE METHODS         #
#####################################
func _update_interface():
	item_list.clear()
	for item in items:
		var item_texture = load(DataImporter.items[item][Constants.ITEM_TEXTURE_PATH])
		item_list.add_item(item, item_texture)
func _on_items_list_item_activated(index):
	if player != null:
		if player.inventory.add_item(items[index]):
			items.remove(index)
			_update_interface()
		else:
			print(_TAG, "Item can not be taken.")
	else:
		push_error(_TAG + "Can not access the inventory of the player.")
#####################################

#####################################
#          SIGNAL METHODS           #
#####################################
func _on_chest_body_entered(body):
	if body.is_in_group("player"): player = body
func _on_chest_body_exited(body):
	if body.is_in_group("player"): player = null
#####################################

#####################################
#          CUSTOM METHODS           #
#####################################
func toggle_pause_all_but_this():
	if get_tree().paused:
		get_tree().paused = false
		pause_mode = Node.PAUSE_MODE_INHERIT
	else:
		pause_mode = Node.PAUSE_MODE_PROCESS
		get_tree().paused = true
#####################################

#####################################
#          DATA SAVE / LOAD         #
#####################################
const _ITEMS = "ITMS"
func _save() -> Dictionary:
	return {
		_ITEMS: items
	}
func _load(data: Dictionary):
	if data.has(_ITEMS): items = data[_ITEMS]
	else: push_warning(_TAG + "Failed to load " + _ITEMS + " data from data dictionary.")
#####################################









