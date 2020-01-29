extends Node2D
###############################
onready var initial_ground_pos = $front_ground.position
onready var ground_rc = $front_ground
onready var wall_rc = $front_wall
###############################
var wall := false
var ground := false

func _on_animator_looking_left():
	$front_wall.rotation_degrees = 180
	$front_ground.position.x = -initial_ground_pos.x

func _on_animator_looking_right():
	$front_wall.rotation_degrees = 0
	$front_ground.position.x = initial_ground_pos.x

func get_sense_data() -> SenseData:
	var data = SenseData.new()
	data.ground_sense = ground_rc.is_colliding()
	data.wall_sense = wall_rc.is_colliding()
	return data
