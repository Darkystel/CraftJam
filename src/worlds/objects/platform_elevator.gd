extends Node2D

enum state {STATE_1, STATE_2}

var current_state = state.STATE_1
export(bool) var requires_charger = false
export(Vector2) var travel_distance = Vector2(0,0)
export(float) var travel_time = 4.0

var charged := false
var initial_position: Vector2
var in_range := false
var in_transit := false
var fail_dialogue = preload('res://src/worlds/objects/elevator_charge_dialogue.tres')

func _ready():
	initial_position = $platform.position
	$liver_down/AnimationPlayer.play("on")
	$liver_up/AnimationPlayer.play("off")

func _unhandled_input(event):
	if event.is_action_pressed("interact") and in_range and not in_transit:
		if requires_charger and not charged:
			if get_parent().get_player().inventory.has_charger:
				charged = true
				get_parent().get_player().inventory.consume_charger()
				$charge_sound.play()
			else:
				get_parent().get_dialogue_overlay().start(fail_dialogue)
				return
		elif requires_charger and charged:
			_travel()
		else:
			_travel()

func _travel():
	match current_state:
		state.STATE_1:
			$liver_down/AnimationPlayer.play("off")
			$liver_up/AnimationPlayer.play("on")
			current_state = state.STATE_2
			$interpolator.interpolate_property($platform, "position", $platform.position, $platform.position + travel_distance, travel_time, Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
			$interpolator.start()
			in_transit = true
			yield($interpolator,"tween_all_completed")
			in_transit = false
		state.STATE_2:
			$liver_down/AnimationPlayer.play("on")
			$liver_up/AnimationPlayer.play("off")
			current_state = state.STATE_1
			$interpolator.interpolate_property($platform, "position", $platform.position, initial_position, travel_time, Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
			$interpolator.start()
			in_transit = true
			yield($interpolator,"tween_all_completed")
			in_transit = false

func _on_liver_body_entered(body):
	if body.is_in_group("player"):
		in_range = true

func _on_liver_body_exited(body):
	if body.is_in_group("player"):
		in_range = false