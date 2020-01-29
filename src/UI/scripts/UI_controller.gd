extends UIController

onready var display = get_node("../inventory")
onready var overlay = get_parent()
var inventory_resource = preload("res://src/UI/inventory_jrj.tscn")
var inventory = inventory_resource.instance()
func _unhandled_input(event):
	if event.is_action_pressed("inventory") and not popping_overlay:
		#inventory.show()
		#overlay.env.add_child(inventory)
		display.display = true
		push_overlay(_INVENTORY)
		get_tree().paused = true
		
