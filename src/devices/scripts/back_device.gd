extends Node2D

export(Vector2) var cursor_offset = Vector2(0, 10)
var drain: float = 0.25
var item_resource: Item
var scene_info: Dictionary

var battery := 100.0
var recover := 0.1

onready var affect_rc = $device/sprite/light_origin/affect

func _ready():
	scene_info = item_resource.scene_params
	if not item_resource.additional_item_info.has('battery_drain'):
		push_error("The item resource of " + item_resource.name + " does not contain the key battery_drain")
	else:
		drain = item_resource.additional_item_info['battery_drain']
	if not scene_info.has('battery'):
		scene_info['battery'] = 100.0

func _physics_process(delta):
	if battery == 0: $cd.start()
	$CanvasLayer/device_hud.set_percent(scene_info['battery'])
	look_at(get_global_mouse_position() + cursor_offset)
	if (global_position.x - get_global_mouse_position().x) > 0:
		$device.scale.y = -1
	else:
		$device.scale.y = 1
	if Input.is_action_pressed("rmb_click") and battery > 0 and $cd.is_stopped():
		$device/sprite/light_origin/light.energy = lerp($device/sprite/light_origin/light.energy, item_resource.additional_item_info['light-power'], 0.2)
		if affect_rc.is_colliding() and affect_rc.get_collider().is_in_group("enemy"):
			affect_rc.get_collider().on_light_case($device/sprite/light_origin.position)
		battery = max(0, battery - drain)
	else:
		$device/sprite/light_origin/light.energy = lerp($device/sprite/light_origin/light.energy, 0, 0.2)
		battery = min(100.0, battery + recover)
	$CanvasLayer/device_hud.set_percent(battery)