extends UIController

func _unhandled_input(event):
	if event.is_action_pressed("inventory") and not popping_overlay:
		push_overlay(_INVENTORY)