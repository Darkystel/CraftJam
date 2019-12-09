extends Overlay

func _ready():
	get_tree().paused = true

func _unhandled_input(event):
	if event.is_action_pressed("escape") or event.is_action_pressed("inventory"):
		get_tree().paused = false
		get_UI_controller().pop_overlay()

