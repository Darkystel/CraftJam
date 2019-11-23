extends Actor

export(Resource) var inventory = null

func _ready(): assert(inventory != null)

func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		velocity.y = -jumping_height

func _physics_process(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction < 0: $character.flip_h = true
	elif direction > 0: $character.flip_h = false
	
	velocity.x = direction * movement_speed
	
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if abs(velocity.x) > 0 and is_on_floor():
		$character.play("walk")
	elif not is_on_floor() and velocity.y < 0:
		$character.play("jump")
	elif not is_on_floor() and velocity.y > 0:
		$character.play("fall")
	else:
		$character.play("idle")
