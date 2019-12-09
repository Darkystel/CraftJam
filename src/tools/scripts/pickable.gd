extends Area2D
const _TAG = "PickableItem : "

export(String) var item = ""

var player = null

func _ready():
	$animator.play("glow")
	if item.empty():
		print(_TAG, "Item not specified, generating random item..")
		item = DataImporter.get_random_item()
	elif not DataImporter.validate_item(item):
		push_warning(_TAG + "Failed to validate item, [" + item + "] is not in the items data dictionary.")
		print(_TAG, "Generating random item due to validation failure..")
		item = DataImporter.get_random_item()

func _on_pickable_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_pickable_body_exited(body):
	if body.is_in_group("player"):
		player = null

func _unhandled_input(event):
	if event.is_action_pressed("interact") and player != null:
		if player.inventory.add_item(item):
			queue_free()
