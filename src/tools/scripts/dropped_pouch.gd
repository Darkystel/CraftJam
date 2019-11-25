extends Area2D

var dropped_pouch: DroppedPouch

var pickable = false
var player
func _unhandled_input(event):
	if event.is_action_pressed("interact") and pickable:
		$CanvasLayer/pouch_overlay.initialize_overlay(player.inventory, dropped_pouch)
		$CanvasLayer/pouch_overlay.visible = true
		$CanvasLayer/pouch_overlay/AnimationPlayer.play("appear")
		get_tree().paused = true

func _on_dropped_pouch_body_entered(body):
	if body.is_in_group("player"):
		pickable = true
		player = body

func _on_dropped_pouch_body_exited(body):
	if body.is_in_group("player"):
		pickable = false
		player = null
