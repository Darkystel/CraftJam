extends Camera2D

#################################
onready var offsetter := $offsetter
onready var duration := $duration
#################################

var amplitude := 1.5
var frequency := 80.0
onready var initial_offset := offset

func start_shaking(amplitude: float = 1.5, frequency: float = 80.0, duration: float = 0.5):
	self.amplitude = amplitude
	self.frequency = frequency
	self.duration.wait_time = duration
	offsetter.connect("tween_all_completed", self, "_offsetting_complete")
	_new_shake()
	self.duration.start()

func _new_shake():
	var new_offset = Vector2(rand_range(-amplitude,amplitude), rand_range(-amplitude,amplitude))
	offsetter.interpolate_property(self,"offset", offset, initial_offset + new_offset, 1/frequency,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	offsetter.start()

func _offsetting_complete():
	_new_shake()

func _reset_offset():
	offsetter.remove_all()
	offsetter.interpolate_property(self,"offset", offset, initial_offset, 1/frequency,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	offsetter.start()

func _on_duration_timeout():
	offsetter.disconnect("tween_all_completed", self, "_offsetting_complete")
	_reset_offset()
