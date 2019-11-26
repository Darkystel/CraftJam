extends RayCast2D

onready var shadow = get_node("..")
onready var vision = get_node("../vision") 
onready var sprite = get_node("../character") 



func _ready():
	print(vision)

func _physics_process(delta):
	if shadow.get_back:
		pass
		
	
	elif not is_colliding() and vision.detected:
		shadow.velocity = Vector2(0,0)
		shadow.fall = false
		shadow.get_back = true
	