extends CanvasLayer
class_name UIController

var overlay_stack = []

var popping_overlay := false

var overlays = {
	"hot_equip": preload("res://src/UI/hot_equip_overlay.tscn"),
	"inventory_manager": preload("res://src/UI/inventory_manager.tscn")
	}

func push_overlay(overlay: String):
	var overlay_to_display = overlays[overlay].instance()
	overlay_stack.push_back(overlay_to_display)
	get_logic_root().turn_off_light()
	add_child(overlay_stack.back())

func pop_overlay():
	if not overlay_stack.empty():
		get_logic_root().turn_on_light()
		popping_overlay = true
		overlay_stack.pop_back()
		yield(get_tree().create_timer(0.25), "timeout")
		get_child(get_children().size() - 1).queue_free()
		get_logic_root().turn_on_light()
		popping_overlay = false

func get_logic_root() -> Player: return get_parent() as Player
