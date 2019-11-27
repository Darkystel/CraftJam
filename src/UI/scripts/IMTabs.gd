extends Tabs
class_name IMTabs

func get_tab_container() -> TabContainer: return get_parent() as TabContainer
func get_parent_overlay() -> Overlay: return get_tab_container().get_parent() as Overlay
func get_logic_root() -> Player: return get_parent_overlay().get_logic_root() as Player
func get_inventory() -> Inventory: return get_logic_root().inventory as Inventory
func flush_leftovers() -> UIFlushInfo: return null