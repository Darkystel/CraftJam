extends Actor


func _physics_process(delta):
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	pass


