extends UIController

func _unhandled_input(event): #Overlays requiring triggers
	if not popping_overlay:
		if event.is_action_pressed("inventory"):
			push_overlay("inventory_manager")
			return
		if event.is_action_pressed("fast_equip"):
			push_overlay("hot_equip")
			return