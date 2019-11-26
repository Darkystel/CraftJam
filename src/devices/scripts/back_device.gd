extends Node2D

export(Vector2) var cursor_offset = Vector2(0, 10)

var battery = 100
var drain = 0.13

func _process(delta):
	look_at(get_global_mouse_position() + cursor_offset)
	if (global_position.x - get_global_mouse_position().x) > 0:
		$device.scale.y = -1
	else:
		$device.scale.y = 1
	if Input.is_action_pressed("rmb_click"):
		$device/sprite/light_origin/light.energy = lerp($device/sprite/light_origin/light.energy, 1.2, 0.2)
		battery = max(0, battery - drain)
		$CanvasLayer/device_hud.set_percent(battery)
	else:
		$device/sprite/light_origin/light.energy = lerp($device/sprite/light_origin/light.energy, 0, 0.2)