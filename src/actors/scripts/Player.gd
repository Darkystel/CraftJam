extends Actor
class_name Player
const _TAG = "Player : "

#####################################
#            CONSTANTS              #
#####################################
const _INVENTORY = "INV"
#####################################

#####################################
#          PUBLIC VARIABLES         #
#####################################
onready var inventory = $inventory
#####################################

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

func _save() -> Dictionary:
	return {
		_INVENTORY: inventory._save(),
		
	}
func _load(data: Dictionary):
	if data.has(_INVENTORY): inventory._load(data[_INVENTORY])
	else: push_error(_TAG + "Failed to load " + _INVENTORY + " data from data dictionary.")
