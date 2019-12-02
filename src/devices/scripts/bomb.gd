extends RigidBody2D

var timer := 2
var fired := false
var damage_enemies := false
var damage_points := 0.0
var light_the_way := false

func _on_RigidBody2D_body_entered(body):
	if not fired:
		$timer.start()
		fired = true

func _on_timer_timeout():
	var tween = Tween.new()
	add_child(tween)
	if light_the_way:
		$light.texture_scale *= 2.5
		tween.interpolate_property($light, "energy", $light.energy, 8, 0.6, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		tween.start()
		yield(tween, "tween_all_completed")
		yield(get_tree().create_timer(3.5),"timeout")
		tween.interpolate_property($light, "energy", $light.energy, 0.01, 0.2, Tween.TRANS_ELASTIC, Tween.EASE_IN)
		tween.start()
		yield(tween, "tween_all_completed")
	else:
		tween.interpolate_property($light, "energy", $light.energy, 12.0, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		tween.start()
		yield(tween,"tween_all_completed")
		if damage_enemies:
			for enemy in $aoe.get_overlapping_bodies():
				if enemy.is_in_group("enemy"):
					enemy.damage(damage_points)
		else:
			for enemy in $aoe.get_overlapping_bodies():
				if enemy.is_in_group("enemy"):
					enemy.on_light_cast(to_global(position))
		tween.interpolate_property($light, "energy", $light.energy, 0.01, 0.7, Tween.TRANS_ELASTIC, Tween.EASE_IN)
		tween.start()
		yield(tween, "tween_all_completed")
	tween.queue_free()
	queue_free()
