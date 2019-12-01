extends Node

var initial_position
var _root
var _fsm

var walk_away_delay := 0
var sense_delay := 1

var left_of := false
var right_of := false

var enable_detection := false
var initial_last_seen := Vector2(0,0)


func _enter():
	walk_away_delay = _root.walk_away_time_msec
	print('Entered walk away state')
	_root.play_animation("walk")
	sense_delay = 1
	initial_position = _root.position
	
	var vision_data = _root.vision.get_vision_data()
	initial_last_seen = vision_data.position_of_last_seen
	
	generate_walk_direction()
	enable_detection = false

func generate_walk_direction():
	if _root.is_looking_right():
		left_of = true
		right_of = false
	else:
		left_of = false
		right_of = true

func _update(delta):
	
	
	if sense_delay < 1:
		var sense_data = _root.sensors.get_sense_data()
		if sense_data.obstacle_encounter():
			return "idle"
		var vision_data = _root.vision.get_vision_data()
		if walk_away_delay == 0:
			if vision_data.player_in_sight and vision_data.player != null:
				var player = vision_data.player
				if _root.is_looking_right():
					if player.position.x <= initial_last_seen.x:
						enable_detection = true
				elif _root.is_looking_left():
					if player.position.x >= initial_last_seen.x:
						enable_detection = true
		else:
			walk_away_delay -= 1
	else:
		print('sense delayed')
		sense_delay -= 1
	if right_of and _root.position.x < initial_position.x + _root.max_walk_away_distance:
		_root.walk_right(_root.idle_walk_speed)
	elif left_of and _root.position.x > initial_position.x - _root.max_walk_away_distance:
		_root.walk_left(_root.idle_walk_speed)
	else:
		return "idle"

func _exit():
	enable_detection = false

func _check_detection():
	if enable_detection:
		var data = _root.vision.get_vision_data()
		return data.player_in_sight and data.player != null
	else:
		return false

func _on_vision_system_out_of_vision():
	enable_detection = true

