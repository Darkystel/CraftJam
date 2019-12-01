extends Node2D

var looking_left: bool setget , get_looking_left
func get_looking_left() -> bool: return $sprite.flip_h

var looking_right: bool setget , get_looking_right
func get_looking_right() -> bool: return not $sprite.flip_h

signal looking_left
signal looking_right
signal animation_finished(animation)

func play_animation(animation):
	$AnimationPlayer.play(animation)

func animation_finished(animation):
	emit_signal("animation_finished", animation)

func look_left():
	$particles.flip_h = true
	$sprite.flip_h = true
	emit_signal("looking_left")

func look_right():
	$particles.flip_h = false
	$sprite.flip_h = false
	emit_signal("looking_right")

