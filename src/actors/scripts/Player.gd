extends Actor

func _physics_process(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction * movement_speed * delta
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
