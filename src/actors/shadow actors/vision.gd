extends RayCast2D





onready var sprite = get_node("../../character")
onready var player = get_node("../../../player")
onready var shadow = get_node("../..")
onready var noground = get_node("../ground_check")
onready var root = get_node('..')
onready var outofvision = get_node("../move_to_last_seen")

var exitmove = false
var stop = false
var detected := false
var direction := Vector2(0,0)

var last_player_seen = Vector2(0,0)
var take_location = true

func detect_animation():
	shadow.velocity = Vector2(0,0)
	sprite.play("detect")
	

func detect():
	if detected == false:
		detect_animation()
		yield(get_tree().create_timer(0.7), "timeout")
		detected = true
	#	sprite.play("walk")




func follow():
		var last_velocity = 0
		direction = shadow.position.direction_to(player.position)
		if noground.condition:
			if not stop:
				if is_colliding() and get_collider().is_in_group("player"):
					shadow.fall = false
					detect()
					if shadow.position > player.position and not noground.get_back:
							sprite.flip_h = true
					else:
							sprite.flip_h = false
							
					if noground.get_back and not outofvision.move:
						var exitmove = true
						noground.go_back()
					elif detected and not shadow.fall and not noground.get_back:
						shadow.velocity.x = direction.x * shadow.movement_speed
						sprite.play("walk")
						if shadow.position > player.position and not noground.get_back:
							sprite.flip_h = true
						else:
							sprite.flip_h = false
						
				else:
					stop = true
					if take_location:
						print("took player location")
						last_player_seen = player.get_global_position()
					sprite.play("idle")
					last_velocity = shadow.velocity.x
					shadow.fall = true
					outofvision.playercollided = false
					detected = false
					take_location = false
					
					if outofvision.again:
						if last_player_seen < shadow.position:
							outofvision.move = true
							outofvision.behind = true
						elif last_player_seen > shadow.position:
							outofvision.move = true
							outofvision.behind = false
						
					
						
					
				


func movetolastseen():
 pass


func check():
	look_at(Vector2(player.position.x,player.position.y-11))
	if sprite.looking_right():
		if shadow.position > player.position :
			set_cast_to(Vector2(15,0))
		else:
			set_cast_to(Vector2(root.detection_range,0))
	elif sprite.looking_left():
		if shadow.position > player.position :
			set_cast_to(Vector2(root.detection_range,0))
		else:
			set_cast_to(Vector2(15,0))
	pass
