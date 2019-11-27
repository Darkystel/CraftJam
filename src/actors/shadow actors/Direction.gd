extends Actor

enum Looking_Direction{
  left,
  right
}

var fall := true
var get_back := false

export(Looking_Direction) var direction

func _ready():
	if direction == Looking_Direction.left:
		$character.flip_h = true
	elif direction == Looking_Direction.right:
		$character.flip_h = false
		
func _physics_process(delta):
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	pass
