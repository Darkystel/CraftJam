extends Node

var _root

func _enter():
	_root.stop()
	_root.play_animation("death")

func _on_animator_animation_finished(animation):
	_root.emit_signal("enemy_died")
	_root.queue_free()
