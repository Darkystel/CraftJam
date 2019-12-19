extends Node
const _TAG = "WorldPickables : "
const _PICKABLE_PATH = "res://src/tools/pickable.tscn"

export(bool) var respawn_items = true
export(float, 0, 0.3) var respawn_threshold = 0.35

const _PICKABLE_N = "pickable_%d"
const _PICKABLE_NAME = "PKBL_NAME"
const _PICKABLE_PICKED = "PKBL_PKD"
const _PICKABLE_POSITION = "PKBL_POS"

var pickables = {}
var last_picked = ""

onready var init_count = self.get_child_count()

func _ready():
	var index = 0
	for pickable in get_children():
		pickable.name = _PICKABLE_N %index
		pickables[pickable.name] = {
			_PICKABLE_NAME: pickable.name,
			_PICKABLE_PICKED: false,
			_PICKABLE_POSITION: pickable.position
		}
		pickable.connect("picked", self, "_on_pickable_picked")
		index += 1


func _on_pickable_picked(name: String):
	if pickables.has(name):
		pickables[name][_PICKABLE_PICKED] = true
		last_picked = name
		print(_TAG, "Initial count ["+ str(init_count) + "], current count ["+str(get_child_count())+"]")
		if (float(get_child_count()) / float(init_count)) < respawn_threshold and respawn_items:
			random_spawn_item()
	else:
		push_error(_TAG + "Failed to find [" + name + "] in the initial dictionary.")

func random_spawn_item(limit_loop_msec: int = 25):
	var mtime = limit_loop_msec
	while mtime > 0:
		randomize()
		var selector = randi() % init_count
		if pickables[_PICKABLE_N %selector][_PICKABLE_PICKED] and (last_picked != _PICKABLE_N %selector):
			var pkble = load(_PICKABLE_PATH).instance()
			add_child(pkble)
			pkble.name = _PICKABLE_N %selector
			pkble.position = pickables[_PICKABLE_N %selector][_PICKABLE_POSITION]
			pickables[_PICKABLE_N %selector][_PICKABLE_PICKED] = false
			return
		mtime -= 1

func _save() -> Dictionary:
	return pickables

func _load(data: Dictionary):
	pickables = data