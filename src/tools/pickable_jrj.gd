extends Area2D

onready var player

export(Resource) var item

var in_sight:= false

func _physics_process(delta):
	if in_sight and Input.is_action_just_pressed("interact") and player.inventory.items_collected < player.inventory.capacity:
		player.add_to_inventory(item)
		queue_free()
		

func _on_pickable_body_entered(body):
	if body.is_in_group("player"):
		player = body
		in_sight = true
	


func _on_pickable_jrj_body_exited(body):
	if body.is_in_group("player"):
		in_sight = false
