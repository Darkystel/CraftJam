extends Node2D

export var detection_range = 0

onready var detect := get_node("player detected")
onready var idle := get_node("player not detected")
onready var ground_check := get_node("ground_check")
onready var root = get_node('.')

var player_detected := false

func _physics_process(delta):
	if player_detected:
		detect.check()
		detect.follow()
		
	else:
		idle.check()
		idle.idle()
		