extends UIController

func _unhandled_input(event): #Overlays requiring triggers
	if event.is_action_pressed("inventory"):
		print("from ui controller : " + str(event))
		push_overlay("inventory_manager")