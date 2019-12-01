extends Node

var _fsm
var _root

func _enter():
	_root.stop()
	_root.play_animation("detect")

func _on_animator_animation_finished(animation):
	if animation == "detect":
		var vision_data = _root.vision.get_vision_data()
		if vision_data.player != null:
			_fsm.change_state("follow")
		else:
			_fsm.change_state("search")