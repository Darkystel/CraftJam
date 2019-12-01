extends Node

onready var timer = $wait


var _fsm
var _root
var initial_position: Vector2
var destination: Vector2 = Vector2(0,0)
var left_of: bool = false
var right_of: bool = false

var waiting := true

func _state_init():
	initial_position = _root.position

func _enter():
	print('entered idle state')
	_root.stop()
	_root.play_animation("idle")
	timer.wait_time = _root.idle_wait_time
	timer.start()

func set_random_destination() -> Vector2:
	var rand = rand_range(-_root.idle_walk_range, _root.idle_walk_range)
	if rand < 0:
		rand = min(-_root.idle_walk_range_min, rand)
	elif rand > 0:
		rand = max(_root.idle_walk_range_min,rand)
	var dest = Vector2(0,0)
	dest.x = initial_position.x + rand
	return dest

func _update(delta):
	if not waiting:
		var sensor_data = _root.sensors.get_sense_data()
		if sensor_data.wall_sense or not sensor_data.ground_sense:
			turn_around()
		if left_of:
			if _root.position.x > destination.x:
				_root.walk_left(_root.idle_walk_speed)
			else:
				_root.stop()
				waiting = true
				timer.start()
		elif right_of:
			if _root.position.x < destination.x:
				_root.walk_right(_root.idle_walk_speed)
			else:
				_root.stop()
				waiting = true
				timer.start()
	else:
		pass

func turn_around():
	destination = -destination
	right_of = not right_of
	left_of = not left_of

func _on_wait_timeout():
	destination = set_random_destination()
	if _root.position.x < destination.x:
		left_of = false
		right_of = true
	else:
		left_of = true
		right_of = false
	waiting = false

func _check_detection():
	var data = _root.vision.get_vision_data()
	return data.player_in_sight and data.player != null