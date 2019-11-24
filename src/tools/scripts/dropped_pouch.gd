extends Area2D

var dropped_pouch: DroppedPouch

var pickable = false
var player
func _unhandled_input(event):
	if event.is_action_pressed("interact") and pickable:
		if player.pick_up_items(dropped_pouch.items):
			queue_free()
		else:
			print("Pouch not picked")

func _on_dropped_pouch_body_entered(body):
	if body.is_in_group("player"):
		pickable = true
		player = body


func _on_dropped_pouch_body_exited(body):
	if body.is_in_group("player"):
		pickable = false
		player = null
