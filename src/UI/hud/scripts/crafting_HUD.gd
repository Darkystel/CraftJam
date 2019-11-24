extends Control

var inventory = null

onready var inventory_list = $VBoxContainer/inventory_panel/inventory_list
onready var crafting_list = $VBoxContainer/crafting_panel/crafting_list

func initialize(inventory):
	self.inventory = inventory

func _ready():
	assert(inventory == null)
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("crafting_hud"):
		if get_tree().paused:
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP, Vector2(256,144))
			inventory_list.clear()
			visible = false
			get_tree().paused = false
		else:
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,SceneTree.STRETCH_ASPECT_KEEP, Vector2(256,144))
			update_grids()
			visible = true
			get_tree().paused = true

func update_grids():
	inventory_list.clear()
	crafting_list.clear()
	for item in inventory.items:
		inventory_list.add_icon_item(item.item_texture)
	for component in inventory.crafting_components:
		crafting_list.add_icon_item(component.item_texture)


func _on_inventory_list_item_activated(index):
	inventory.put_in_crafting(inventory.items[index])
	update_grids()


func _on_crafting_list_item_activated(index):
	inventory.put_back_in_items(inventory.crafting_components[index])
	update_grids()


func _on_craft_pressed():
	var msg = inventory.try_crafting() as Message
	if msg.success:
		update_grids()
	$description.text = msg.description
