extends Node2D

enum state {UP, DOWN}
export(state) var current_state = state.DOWN
export(bool) var requires_charger = false

var charged := false
var in_range := false
var in_transit := false
var fail_dialogue = preload('res://src/worlds/objects/elevator_charge_dialogue.tres')
func _ready():
	if current_state == state.UP:
		$AnimationPlayer.play("go_up")
		in_transit = true

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
			match current_state:
				state.UP:
					current_state = state.DOWN
					$AnimationPlayer.play("go_down")
					in_transit = true
				state.DOWN:
					current_state = state.UP
					$AnimationPlayer.play("go_up")
					in_transit = true
		else:
			match current_state:
				state.UP:
					current_state = state.DOWN
					$AnimationPlayer.play("go_down")
					in_transit = true
				state.DOWN:
					current_state = state.UP
					$AnimationPlayer.play("go_up")
					in_transit = true
		

func _on_liver_body_entered(body):
	if body.is_in_group("player"):
		in_range = true

func _on_liver_body_exited(body):
	if body.is_in_group("player"):
		in_range = false


func _on_AnimationPlayer_animation_finished(anim_name):
	in_transit = false
