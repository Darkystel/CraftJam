extends KinematicBody2D
class_name Actor

export(float) var gravity := 20.0
export(float) var movement_speed := 100.0
export(float) var jumping_height := 280.0

var velocity := Vector2(0,0)
