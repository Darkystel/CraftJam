extends Actor

export(Resource) var inventory

func _ready(): 
	assert(inventory != null)
	inventory.initialize_recipes()
	$CanvasLayer/HUD.get_node("inventory").initialize_inventory(inventory)
	$CanvasLayer/crafting_HUD.initialize(inventory)

func pick_up_item(item):
	if inventory.add_to_inventory(item):
		return true
	else:
		return false

func pick_up_items(items) -> bool:
	if inventory.get_available_capacity():
		
		for item in items:
			inventory.add_to_inventory(item)
			
		return true
	else:
		print("Not enough place for all those items!")
		return false

func _physics_process(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction < 0: $character.flip_h = true
	elif direction > 0: $character.flip_h = false
	
	if Input.is_action_pressed("jump"):
		if is_on_floor() :
			velocity.y = -jumping_height
	
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
