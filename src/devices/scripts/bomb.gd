extends RigidBody2D

var timer := 2
var fired := false

func _on_RigidBody2D_body_entered(body):
	if not fired:
		$timer.start()
		fired = true

func _on_timer_timeout():
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property($light, "energy", $light.energy, 3.5, 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_all_completed")
	tween.interpolate_property($light, "energy", $light.energy, 0.01, 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	tween.queue_free()
	queue_free()
