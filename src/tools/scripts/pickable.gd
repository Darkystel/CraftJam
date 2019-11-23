extends Area2D

export(Resource) var item = null

var pickable = false
var player = null

func _ready(): assert(item != null)

func _on_pickable_body_entered(body):
	if body.is_in_group("player"): 
		pickable = true
		player = body

func _on_pickable_body_exited(body):
	if body.is_in_group("player"): 
		pickable = false
		player = body

func _unhandled_input(event):
	if event.is_action_pressed("interact") and pickable:
		if player.inventory.add_to_inventory(item):
			queue_free()