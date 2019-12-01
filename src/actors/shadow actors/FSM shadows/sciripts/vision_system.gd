extends Node2D

export(Vector2) var raycast_offset = Vector2(0,-8)
#################################
onready var aggro_area = $aggro_area
onready var  line_of_sight = $line_of_sight
#################################

var player: Player = null
var player_in_sight: bool = false
var position_of_last_seen: Vector2

signal out_of_vision

func _physics_process(delta):
	var overlapping_bodies = aggro_area.get_overlapping_bodies()
	player = null
	for body in overlapping_bodies:
		if body.is_in_group("player"):
			player = body
		else:
			player_in_sight = false
	if player != null:
		line_of_sight.look_at(player.position + raycast_offset)
		if line_of_sight.is_colliding() and line_of_sight.get_collider().is_in_group('player'):
			player_in_sight = true
			position_of_last_seen = player.position
		else:
			player_in_sight = false

func get_vision_data() -> VisionData:
	var data = VisionData.new()
	data.player = player
	data.player_in_sight = player_in_sight
	data.position_of_last_seen = position_of_last_seen
	return data

func _on_aggro_area_body_exited(body):
	emit_signal("out_of_vision")
