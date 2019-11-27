extends RayCast2D

onready var shadow = get_node("../..")
onready var vision = get_node("../player detected")
onready var player = get_node("../../../player")
onready var sprite = get_node("../../character")
onready var outofvision = get_node("../move_to_last_seen") 
onready var root = get_node('..')

var get_back := false
var condition = true

func go_back():
	var direction = 0
	shadow.fall = true
	var lower = false
	if player.position.x < shadow.position.x:
		lower = true
		sprite.flip_h = true
	elif player.position.x > shadow.position.x:
		lower = false
		sprite.flip_h = false
	if lower:
		print('lower true')
		direction = shadow.position.direction_to(player.position)
		condition = false
		sprite.play("idle")
		vision.detected = false
		yield(get_tree().create_timer(1), "timeout")
		sprite.flip_h = false
		shadow.velocity.x = -direction.x * shadow.movement_speed/1.5
		yield(get_tree().create_timer(0.7), "timeout")
		get_back = false
		condition = true
		lower = false
		root.player_detected=false
	else:
		print('lower false')
		direction = shadow.position.direction_to(player.position)
		condition = false
		sprite.play("idle")
		vision.detected = false
		yield(get_tree().create_timer(1), "timeout")
		sprite.flip_h = true
		shadow.velocity.x = -direction.x * shadow.movement_speed/1.5
		yield(get_tree().create_timer(2), "timeout")
		get_back = false
		condition = true
		root.player_detected=false


func _physics_process(delta):
	if get_back:
		pass

	elif not is_colliding() and vision.detected and not outofvision.move:
		shadow.velocity = Vector2(0,0)
		get_back = true
		
	elif not is_colliding() and not root.player_detected and not outofvision.move:
		
		shadow.velocity = Vector2(0,0)
		get_back = true
	
	if sprite.flip_h:
		set_cast_to(Vector2(-5,5))
	else:
		set_cast_to(Vector2(5,5))
	