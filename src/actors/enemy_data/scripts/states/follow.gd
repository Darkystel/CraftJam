extends Node

var _fsm
var _root

func _enter():
	print("entered follow state")
	_root.play_animation("follow")

func _update(delta):
	var sense_data = _root.sensors.get_sense_data()
	var vision_data = _root.vision.get_vision_data()
	if vision_data.player_in_sight:
		var destination = vision_data.position_of_last_seen
		if _root.position.x > destination.x:
			_root.walk_left(_root.movement_speed)
		elif _root.position.x < destination.x:
			_root.walk_right(_root.movement_speed)
		if sense_data.obstacle_encounter():
			return "aggro_wait"
	else:
		return "search"