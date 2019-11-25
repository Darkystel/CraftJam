extends RayCast2D


export var detection_range = 0


onready var sprite = get_node("../character")
onready var player = get_node("../../player")
onready var shadow = get_node("..")

var detected := false
var update := true

func detect_animation():
	shadow.velocity = Vector2(0,0)
	sprite.play("detect")
	

func detect():
	shadow.fall = false
	if detected == false:
		detect_animation()
		yield(get_tree().create_timer(0.7), "timeout")
		detected = true
	#	sprite.play("walk")




func _physics_process(delta):
	look_at(Vector2(player.position.x,player.position.y-8))
	var direction = shadow.position.direction_to(player.position)
	var last_velocity = 0
	if sprite.looking_right():
		if shadow.position > player.position :
			set_cast_to(Vector2(15,0))
		else:
			set_cast_to(Vector2(detection_range,0))
	elif sprite.looking_left():
		if shadow.position > player.position :
			set_cast_to(Vector2(detection_range,0))
		else:
			set_cast_to(Vector2(15,0))

	if is_colliding() and get_collider().is_in_group("player"):
		update = false
		detect()
		if shadow.get_back:
			sprite.play("idle")
			yield(get_tree().create_timer(1), "timeout")
			sprite.flip_h = true
			shadow.velocity.x = -direction.x * shadow.movement_speed/1.5
			yield(get_tree().create_timer(2), "timeout")
			shadow.get_back = false
			
			
		elif detected and not shadow.fall and not shadow.get_back:
			shadow.velocity.x = direction.x * shadow.movement_speed
			sprite.play("walk")
		if shadow.position > player.position and not shadow.get_back:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		
	else:
		
		sprite.play("idle")
		last_velocity = shadow.velocity.x
		shadow.velocity.x = lerp(last_velocity,0,0.01)
		detected = false
		shadow.fall = true
		
	