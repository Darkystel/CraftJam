extends Node

var initial_position
var _root
var _fsm

var sense_delay := 1

var left_of := false
var right_of := false

var enable_detection := false

func _state_init():
	initial_position = _root.position

func _enter():
	print('entered walk away state')
	_root.play_animation("walk")
	sense_delay = 1
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
	if right_of:
		_root.walk_right(_root.idle_walk_speed)
	elif left_of:
		_root.walk_left(_root.idle_walk_speed)
	if sense_delay < 1:
		var sense_data = _root.sensors.get_sense_data()
		if sense_data.obstacle_encounter():
			return "idle"
	else:
		print('sense delayed')
		sense_delay -= 1

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
