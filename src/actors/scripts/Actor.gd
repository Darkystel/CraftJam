extends KinematicBody2D
class_name Actor

export(float) var gravity := 10.0
export(float) var movement_speed := 100.0
export(float) var jumping_height := 200.0

var velocity := Vector2(0,0)
onready var environment = get_parent()

