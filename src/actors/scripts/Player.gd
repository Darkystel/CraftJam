extends Actor
class_name Player

var presence := 10.0
var hp := 100.0
var recover := false

export(Resource) var inventory
export(bool) var process = true setget set_player_process, get_player_process
func set_player_process(value: bool):
	set_physics_process(value)
	process = value
func get_player_process() -> bool: return process

onready var equipments = $equipments

signal player_died

func damage_player():
	recover = false
	$recovery_time.stop()
	hp -= 0.5
	if hp <= 0:
		kill_player()
	$recovery_time.start()

func kill_player():
	set_process(false)
	set_physics_process(false)
	emit_signal("player_died")

func force_idle():
	$character.play("idle")

func _ready(): 
	assert(inventory != null)
	inventory.initialize_recipes()
	set_process(true)
	set_physics_process(process)

func set_limits(limit_left, limit_right):
	$main_camera.limit_left = limit_left
	$main_camera.limit_right = limit_right

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

func _process(delta):
	if recover:
		hp += 2.5
		if hp >= 100.0:
			hp = 100.0
			recover = false

func _physics_process(delta):
	var snap_vector = Vector2.DOWN * 2
	
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction < 0: $character.flip_h = true
	elif direction > 0: $character.flip_h = false
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() :
			$character.play("jump")
			velocity.y = -jumping_height
			snap_vector = Vector2.ZERO
	
	velocity.x = direction * movement_speed
	
	velocity.y += gravity
	
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP)
	if abs(velocity.x) > 0 and is_on_floor():
		$character.play("walk")
	
	elif not is_on_floor() and velocity.y > 0:
		$character.play("fall")
	elif is_on_floor():
		$character.play("idle")


func _on_recovery_time_timeout():
	recover = true
