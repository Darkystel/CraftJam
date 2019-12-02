extends Node2D

onready var player: Player = get_parent()

var currently_equipped: Item = null

func equip(item: Item):
	if item == currently_equipped:
		unequip()
	else:
		unequip()
		add_equipment(item)

func add_equipment(item: Item):
	if item.is_droppable():
		var scn = item.item_scene.instance()
		player.environment.add_child(scn)
		scn.position = player.position
		player.inventory.consume_hot_equip(item)
		return
	currently_equipped = item
	currently_equipped.connect("unequip", self, "unequip")
	var item_scene = item.item_scene.instance()
	item_scene.item_resource = currently_equipped
	add_child(item_scene)
	if item.is_throwable():
		item_scene.connect("device_thrown",self,"_on_device_thrown")
		

func _on_device_thrown(throwable, impulse, initial_position):
	var parent_node = throwable.get_parent().get_parent()
	throwable.get_parent().remove_child(throwable)
	parent_node.queue_free()
	get_parent().environment.add_child(throwable)
	player.inventory.consume_hot_equip(currently_equipped)
	currently_equipped = null
	throwable.mode = RigidBody2D.MODE_RIGID
	throwable.global_position = initial_position
	throwable.apply_central_impulse(impulse)

func unequip():
	if get_child(get_child_count()-1) == null: return
	get_child(get_child_count()-1).queue_free()
	currently_equipped.disconnect("unequip", self, "unequip")
	currently_equipped = null
