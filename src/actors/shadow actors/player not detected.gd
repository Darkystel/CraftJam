extends Node2D

onready var vision = get_node("../player detected")

onready var sprite = get_node("../../character")
onready var player = get_node("../../../player")
onready var shadow = get_node("../..")
onready var root = get_node('..')
onready var noground = get_node("../ground_check")

var direction = Vector2(0,0)
var last_velocity = 0

func idle():
	sprite.play("idle")
	shadow.velocity.x = 0
	if noground.get_back:
		shadow.velocity.x = 0
		yield(get_tree().create_timer(0.7), "timeout")
		if vision.last_player_seen.x < shadow.position.x:
			shadow.velocity.x = lerp(10,0,0.01)
			sprite.flip_h = false
		elif vision.last_player_seen.x > shadow.position.x:
			shadow.velocity.x = lerp(-10,0,0.01)
			sprite.flip_h = true
		noground.get_back = false
		vision.detected = false

		
		

func check():
	
	if vision.is_colliding() and vision.get_collider().is_in_group("player"):
		root.player_detected = true
	elif vision.is_colliding() and not vision.get_collider().is_in_group("player"):
		root.player_detected = false
	
	vision.look_at(Vector2(player.position.x,player.position.y-8))
	if sprite.looking_right():
		if shadow.position > player.position :
			vision.set_cast_to(Vector2(15,0))
		else:
			vision.set_cast_to(Vector2(root.detection_range,0))
	elif sprite.looking_left():
		if shadow.position > player.position :
			vision.set_cast_to(Vector2(root.detection_range,0))
		else:
			vision.set_cast_to(Vector2(15,0))