extends Node2D

onready var sprite = get_node("../../character")
onready var player = get_node("../../../player")
onready var shadow = get_node("../..")
onready var vision = get_node("../player detected")
onready var noground = get_node("../ground_check")
onready var root = get_node('..')
var x = 0
var y = 0
var move := false
var timer = null
var again = true
var fall = true
var direction = Vector2(0,0)

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
	if move:
		timer = Timer.new()
		if again:
			print(vision.last_player_seen)
			again = false
			timer.connect("timeout",self,"_on_timer_timeout") 
			timer.set_one_shot(true)
			timer.set_wait_time(5)
			add_child(timer)
			timer.start()
			print(timer.get_time_left())
			direction = shadow.position.direction_to(vision.last_player_seen)
			if shadow.position.x == vision.last_player_seen.x:
				print('equal')
		if not noground.is_colliding():
			shadow.velocity.x = 0*0
			noground.go_back()
			
			
			#if vision.is_colliding() and vision.get_collider().is_in_group("player") and timer.get_wait_time() > 0:
				#print('stopped')
				#timer.stop()
			pass
	pass
	
func _on_timer_timeout():
	x = vision.last_player_seen.x
	y = vision.last_player_seen.y
	print("done")
	shadow.set_global_position(Vector2(x,y))
	print(shadow.position)
	print(vision.last_player_seen)
	
	print(x)
	print(y)
	
	move = false
	root.player_detected=false
	again = true
	pass