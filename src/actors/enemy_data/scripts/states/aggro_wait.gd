extends Node

var _root
var _fsm

var prevent_search := false

func _from_search():
	prevent_search = true

func _state_init():
	$aggro_timer.wait_time = _root.aggro_wait_time

func _enter():
	print("entered aggro state")
	_root.play_animation("idle")
	print($aggro_timer.wait_time)
	_root.stop()
	$aggro_timer.start()

func _update(delta):
	var sense_data = _root.sensors.get_sense_data()
	var vision_data = _root.vision.get_vision_data()
	if vision_data.player_in_sight:
		var destination = vision_data.player.position
		if destination.x < _root.position.x:
			if _root.is_looking_left():
				if sense_data.obstacle_encounter():
					return
		elif destination.x > _root.position.x:
			if _root.is_looking_right():
				if sense_data.obstacle_encounter():
					return
		return "follow"
		
	else:
		if not prevent_search:
			return "search"

func _on_aggro_timer_timeout():
	print('should change state')
	_fsm.change_state("walk_away")
