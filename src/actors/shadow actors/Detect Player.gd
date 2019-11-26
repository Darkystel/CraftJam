extends Node

onready var vision = get_node("vision")



func _process(delta):
	vision.follow()
	pass