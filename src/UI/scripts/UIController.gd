extends CanvasLayer
class_name UIController

var overlay_stack = []

var overlays = {
	"hot_equip": preload("res://src/UI/hot_equip_overlay.tscn"),
	"inventory_manager": preload("res://src/UI/inventory_manager.tscn")
	}

func push_overlay(overlay: String):
	var overlay_to_display = overlays[overlay].instance()
	overlay_stack.push_back(overlay_to_display)
	add_child(overlay_stack.back())

func pop_overlay():
	get_child(get_children().size() - 1).queue_free()
	overlay_stack.pop_back()

func get_logic_root() -> Player: return get_parent() as Player
