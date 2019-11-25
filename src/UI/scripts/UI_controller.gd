extends UIController

func _unhandled_input(event): #Overlays requiring triggers
	if event.is_action_pressed("inventory"):
		push_overlay("inventory_manager")
	if event.is_action_pressed("fast_equip"):
		push_overlay("hot_equip")