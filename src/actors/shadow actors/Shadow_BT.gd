extends Actor

enum Looking_Direction{
  left,
  right
}

export(Looking_Direction) var looking_direction

signal change_direction(direction)

onready var vision = get_node("detectors/vision")
onready var sense = get_node("detectors/sense")
onready var ground = get_node("detectors/ground")
onready var wall = get_node("detectors/wall")

func play_animation(animation):
	$character.play(animation)


func sprite():
	return $character

func look_left():
	$character.flip_h = true
	emit_signal("change_direction", "left")
	pass
	
func look_right():
	$character.flip_h = false
	emit_signal("change_direction", "right")
	pass

#func _unhandled_input(event):
	#if event.is_action_pressed("ui_left"):
		#look_left()
	#elif event.is_action_pressed("ui_right"):
		#look_right()
	#elif event.is_action_pressed("test_button"):
		#self.disconnect("change_direction",$detectors,"_on_Tall_Shadow_change_direction")
		

func _ready():
	if looking_direction == Looking_Direction.left:
		look_left()
	elif looking_direction == Looking_Direction.right:
		look_right()
	pass