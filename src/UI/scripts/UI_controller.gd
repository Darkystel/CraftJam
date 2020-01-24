extends UIController

onready var overlay = get_parent()
var inventory_resource = preload("res://src/UI/inventory_jrj.tscn")
var inventory = inventory_resource.instance()
func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		#inventory.show()
		#overlay.env.add_child(inventory)
		push_overlay(_INVENTORY)
		get_tree().paused = true
		
