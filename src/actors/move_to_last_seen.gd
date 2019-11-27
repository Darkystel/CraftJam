extends Node2D

onready var sprite = get_node("../../character")
onready var player = get_node("../../../player")
onready var shadow = get_node("../..")
onready var vision = get_node("../player detected")
onready var noground = get_node("../ground_check")
onready var root = get_node('..')

var playercollided = false

var x = 0
var y = 0

var behind = false
var move := false
var checkcollide = true
var again = true
var fall = true


var direction = Vector2(0,0)
var timer = null

func stop():
	shadow.velocity.x = 0
	yield(get_tree().create_timer(0.7), "timeout")
	if vision.last_player_seen.x < shadow.position.x:
		shadow.velocity.x = lerp(10,0,0.01)
		sprite.flip_h = false
	elif vision.last_player_seen.x > shadow.position.x:
		shadow.velocity.x = lerp(-10,0,0.01)
		sprite.flip_h = true
	fall = true


func _physics_process(delta):
	if not noground.is_colliding() and not noground.get_back:
		move = false
		shadow.velocity.x = 0
		noground()
		pass
	
	elif move  and not playercollided:
		move()

	
func move():
	direction = shadow.position.direction_to(vision.last_player_seen)
	if shadow.get_global_position() < vision.last_player_seen and not behind and move:
		again = false
		if vision.is_colliding() and vision.get_collider().is_in_group("player"):
			print('player detected')
			playercollided = true
			move = false
			vision.detected = true
			vision.take_location = true
			again = true
		elif not playercollided and noground.get_back:
			shadow.velocity.x = direction.x * 25
			root.player_detected=false
		
	elif shadow.get_global_position() > vision.last_player_seen and behind and move:
		again = false
		if vision.is_colliding() and vision.get_collider().is_in_group("player"):
			print('player detected')
			playercollided = true
			move = false
			vision.detected = true
			vision.take_location = true
			again = true
		elif not playercollided  and noground.get_back:
			shadow.velocity.x = direction.x * 25
			root.player_detected=false
	else:
		print('shadow stopped')
		shadow.velocity = Vector2(0,0)
		move = false
		vision.take_location = true
		root.player_detected=false
		again = true
		playercollided = false
			
			
	
	
func noground():
	
	shadow.velocity = Vector2(0,0)
	if shadow.get_global_position() < vision.last_player_seen and not behind:
		yield(get_tree().create_timer(1), "timeout")
		sprite.flip_h = true
		shadow.velocity.x = -direction.x * shadow.movement_speed
		yield(get_tree().create_timer(2), "timeout")
		move = false
		root.player_detected=false
		again = true
	elif shadow.get_global_position() > vision.last_player_seen and behind:
		yield(get_tree().create_timer(1), "timeout")
		shadow.velocity.x = -direction.x * shadow.movement_speed
		sprite.flip_h = false
		yield(get_tree().create_timer(2), "timeout")
		move = false
		root.player_detected=false
		again = true
		