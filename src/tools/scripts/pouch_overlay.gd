extends Control

var inventory: Inventory
var pouch: DroppedPouch

onready var parent = get_parent().get_parent()

func initialize_overlay(inventory: Inventory, pouch: DroppedPouch):
	self.inventory = inventory
	self.pouch = pouch
	pouch.connect("pouch_emptied", self, "on_pouch_emptied")
	update_grid()

func update_grid():
	$item_list.clear()
	for item in pouch.items:
		$item_list.add_icon_item(item.item_texture)

func _on_item_list_item_activated(index):
	if inventory.get_available_capacity() > 0:
		var item_to_pick = pouch.consume_item(pouch.items[index])
		inventory.add_to_inventory(item_to_pick)
		update_grid()

func _on_close_pressed():
	visible = false
	get_tree().paused = false

func on_pouch_emptied():
	visible = false
	get_tree().paused = false
	parent.queue_free()
