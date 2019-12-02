extends Node2D

func _ready():
	$Tween.interpolate_property($Light2D, "energy", 0.01, 3, 1.0, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()
	$Timer.start()

func _on_Timer_timeout():
	$Tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,0), 1.0, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	queue_free()

func _physics_process(delta):
	for body in $aoe.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			body.on_light_cast(to_global(position))
