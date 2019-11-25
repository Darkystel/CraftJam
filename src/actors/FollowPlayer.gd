extends RayCast2D


onready var sprite = get_node("../character")
onready var player = get_node("../../player")
onready var shadow = get_node("..")



func _process(delta):
	look_at(Vector2(player.position.x,player.position.y-8))
	var direction = shadow.position.direction_to(player.position)

	if sprite.looking_right():
		if shadow.position > player.position :
			set_cast_to(Vector2(15,0))
		else:
			set_cast_to(Vector2(50,0))
	elif sprite.looking_left():
		if shadow.position > player.position :
			set_cast_to(Vector2(50,0))
		else:
			set_cast_to(Vector2(15,0))
	

	if is_colliding() and get_collider().is_in_group("player"):
		shadow.velocity = direction * shadow.movement_speed
		sprite.play("walk")
		if shadow.position > player.position :
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		
	else:
		sprite.play("idle")
		shadow.velocity = Vector2(0,0)
	
