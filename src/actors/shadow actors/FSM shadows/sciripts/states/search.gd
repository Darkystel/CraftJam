extends Node

var _root
var _fsm
var last_seen: Vector2
var left_of := false
var right_of := false

func _enter():
	print('Entered search state')
	_root.play_animation("walk")
	generate_search_data()

func generate_search_data():
	var vision_data = _root.vision.get_vision_data()
	last_seen = vision_data.position_of_last_seen
	if _root.position.x < last_seen.x:
		right_of = true
		left_of = false
	else:
		left_of = true
		right_of = false

func _update(delta):
	var sense_data = _root.sensors.get_sense_data()
	if left_of:
		if sense_data.obstacle_encounter():
			return "aggro_wait"
		if _root.position.x > last_seen.x:
			_root.walk_left(_root.idle_walk_speed)
		else:
			return "idle"
	elif right_of:
		if sense_data.obstacle_encounter():
			return "aggro_wait"
		if _root.position.x < last_seen.x:
			_root.walk_right(_root.idle_walk_speed)
		else:
			return "idle"

func _check_follow():
	var vision_data = _root.vision.get_vision_data()
	return vision_data.player_in_sight and vision_data.player != null