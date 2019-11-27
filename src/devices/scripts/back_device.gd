extends Node2D

export(Vector2) var cursor_offset = Vector2(0, 10)
var drain: float
var item_resource: Item
var scene_info: Dictionary

func _ready():
	scene_info = item_resource.scene_params
	if not item_resource.additional_item_info.has('battery_drain'):
		push_error("The item resource of " + item_resource.name + " does not contain the key battery_drain")
	else:
		drain = item_resource.additional_item_info['battery_drain']
	if not scene_info.has('battery'):
		scene_info['battery'] = 100.0

func _process(delta):
	$CanvasLayer/device_hud.set_percent(scene_info['battery'])
	look_at(get_global_mouse_position() + cursor_offset)
	if (global_position.x - get_global_mouse_position().x) > 0:
		$device.scale.y = -1
	else:
		$device.scale.y = 1
	if Input.is_action_pressed("rmb_click"):
		$device/sprite/light_origin/light.energy = lerp($device/sprite/light_origin/light.energy, 1.2, 0.2)
		scene_info['battery'] = max(0, scene_info['battery'] - drain)
	else:
		$device/sprite/light_origin/light.energy = lerp($device/sprite/light_origin/light.energy, 0, 0.2)