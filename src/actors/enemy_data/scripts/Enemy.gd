extends Actor

export(float) var acceleration = 7.5
export(float) var idle_walk_speed = 30
export(float) var idle_walk_range = 35
export(float) var idle_walk_range_min = 20
export(float) var idle_wait_time = 0.8
export(float) var aggro_wait_time = 1.5
export(float) var walk_away_time_msec = 70
export(float) var max_walk_away_distance = 96.0

####################################
onready var vision = $vision_system
onready var sensors = $sensors
onready var animator = $animator
onready var spawn_position = self.position
####################################

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = gravity
	move_and_slide(velocity, Vector2.UP)

func play_animation(animation):
	$animator.play_animation(animation)

func walk_left(speed: float):
	velocity.x = max(velocity.x - acceleration, -speed)
	$animator.look_left()
func is_looking_left() -> bool:
	return $animator.looking_left

func walk_right(speed: float):
	velocity.x = min(velocity.x + acceleration, speed)
	$animator.look_right()
func is_looking_right() -> bool:
	return $animator.looking_right

func stop():
	velocity.x = 0