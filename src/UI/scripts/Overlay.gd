extends Control
class_name Overlay

func get_UI_controller(): return get_parent()
func get_logic_root() -> Player: return get_UI_controller().get_logic_root()
func get_environment() -> Node2D: return get_logic_root().get_parent() as Node2D
func get_inventory() -> Inventory: return get_logic_root().inventory as Inventory