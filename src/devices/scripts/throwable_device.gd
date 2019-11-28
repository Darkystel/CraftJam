extends Node2D

var item_resource: Item

var threshold_distance = 15
var threshold_height_offset = 5
var valid_position
var throw_strength = 100

signal device_thrown(throwable, impulse, initial_position)

func _process(delta):
	var mouse_distance = global_position.distance_to(get_global_mouse_position())
	if abs(mouse_distance) > threshold_distance:
		if get_global_mouse_position().y < global_position.y + threshold_height_offset:
			$rotator.look_at(get_global_mouse_position())
			valid_position = get_global_mouse_position()

func _unhandled_input(event):
	if event.is_action_pressed("rmb_click") and valid_position != null:
		# to_local(valid_position).normalized() * 100
		emit_signal("device_thrown", $rotator/RigidBody2D, to_local(valid_position).normalized() * 100, $rotator/RigidBody2D.global_position)
