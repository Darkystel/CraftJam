extends Node

var initial_position
var _root
var _fsm

var left_of := false
var right_of := false

func _enter():
	print('Entered run away state')
	_root.play_animation("walk")

func generate_walk_direction(danger_pos):
	if _root.to_global(_root.position).x < danger_pos.x:
		left_of = true
		right_of = false
	elif _root.to_global(_root.position).x > danger_pos.x:
		right_of = true
		left_of = false
	$cd.start()

func _update(delta):
	var sense_data = _root.sensors.get_sense_data()
	#adjust to position
	if right_of:
		if sense_data.obstacle_encounter():
			_root.stop()
		else:
			_root.walk_right(_root.run_away_speed)
	elif left_of:
		if sense_data.obstacle_encounter():
			_root.stop()
		else:
			_root.walk_left(_root.run_away_speed)
	else:
		return "idle"


func _on_cd_timeout():
	_fsm.change_state("idle")
