extends Overlay

func _ready():
	get_tree().paused = true
	initialize_items()
	$AnimationPlayer.play("appear")

func _unhandled_input(event):
	if event.is_action_pressed("escape"):
		get_tree().paused = false
		$AnimationPlayer.play("disappear")
		get_UI_controller().pop_overlay()

func initialize_items():
	for index in range(0,get_inventory().hot_equip.size()):
		$inventory.get_children()[index].pass_item(get_inventory().hot_equip[index])
		$inventory.get_children()[index].connect("item_pressed", self, "item_pressed")

func item_pressed(item):
	get_tree().paused = false
	$AnimationPlayer.play("disappear")
	print("Item pressed : " + item.name)
	get_UI_controller().pop_overlay()