extends Actor
class_name Player

export(Resource) var inventory
export(bool) var process = true setget set_player_process, get_player_process
func set_player_process(value: bool):
	set_physics_process(value)
	process = value
func get_player_process() -> bool: return process

onready var equipments = $equipments

func _ready(): 
	assert(inventory != null)
	inventory.initialize_recipes()
	set_physics_process(process)

func set_light_energy(value: float):
	$light.energy = value

func _unhandled_input(event):
	if event.is_action_pressed("test_button"):
		$main_camera.start_shaking(0.8)

func pick_up_item(item):
	if inventory.add_to_inventory(item):
		set_physics_process(false)
		$character.play("pickup")
		yield($character, "animation_finished")
		set_physics_process(true)
		return true
	else:
		return false

func _physics_process(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction < 0: $character.flip_h = true
	elif direction > 0: $character.flip_h = false
	
	if Input.is_action_just_pressed("jump"):
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
