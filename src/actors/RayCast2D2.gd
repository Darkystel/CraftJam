extends RayCast2D

onready var sprite = get_node("../character")
onready var player = get_node("../../player")
onready var shadow = get_node("..")

func _process(delta):
	if sprite.looking_right():
			set_cast_to(Vector2(4,10))
	elif sprite.looking_left():
			set_cast_to(Vector2(-4,15))
	if is_colliding():
		print("test")