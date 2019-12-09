extends CanvasLayer
class_name UIController

var overlay_stack = []

var popping_overlay := false

const _INVENTORY = "INV"
var overlays = {
	_INVENTORY: preload("res://src/UI/inventory.tscn")
	}

func push_overlay(overlay: String):
	var overlay_to_display = overlays[overlay].instance()
	overlay_stack.push_back(overlay_to_display)
	add_child(overlay_stack.back())

func pop_overlay():
	if not overlay_stack.empty():
		popping_overlay = true
		overlay_stack.pop_back()
		get_child(get_children().size() - 1).queue_free()
		yield(get_tree().create_timer(0.25), "timeout")
		popping_overlay = false

func get_logic_root() -> Player: return get_parent() as Player
