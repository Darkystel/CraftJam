extends Control

var inventory: Inventory

onready var inventory_list = $VBoxContainer/inventory_panel/inventory_list
onready var crafting_list = $VBoxContainer/crafting_panel/crafting_list
onready var parent = get_parent().get_parent()
onready var environment = parent.get_parent()

var selected_item: Item
var items_to_drop = []

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
			crafting_list.clear()
			if not items_to_drop.empty():
				var pouch = load("res://src/tools/dropped_pouch.tscn").instance()
				environment.add_child(pouch)
				pouch.dropped_pouch = create_pouch(items_to_drop, true)
				pouch.position = parent.position
			visible = false
			get_tree().paused = false
		else:
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,SceneTree.STRETCH_ASPECT_KEEP, Vector2(256,144))
			update_grids()
			visible = true
			get_tree().paused = true

func create_pouch(items, consumeInput: bool = false) -> DroppedPouch:
	var pouch = DroppedPouch.new()
	pouch.stash_items(items)
	if consumeInput:
		print("should clear input")
		items.clear()
		print(items)
	return pouch

func update_grids():
	inventory_list.clear()
	crafting_list.clear()
	for item in inventory.items:
		inventory_list.add_icon_item(item.item_texture)
	for component in inventory.crafting_components:
		crafting_list.add_icon_item(component.item_texture)


func _on_inventory_list_item_activated(index):
	$item_description_panel.clear()
	inventory.put_in_crafting(inventory.items[index])
	update_grids()


func _on_crafting_list_item_activated(index):
	$item_description_panel.clear()
	inventory.put_back_in_items(inventory.crafting_components[index])
	update_grids()


func _on_craft_pressed():
	var msg = inventory.try_crafting() as Message
	if msg.success:
		update_grids()
	$description.text = msg.description

func _on_crafting_list_item_selected(index):
	$item_description_panel.update_item(inventory.crafting_components[index], true)

func _on_inventory_list_item_selected(index):
	$item_description_panel.update_item(inventory.items[index])
	selected_item = inventory.items[index]

func _on_drop_pressed():
	$item_description_panel.clear()
	items_to_drop.push_back(inventory.consume_item(selected_item))
	update_grids()
