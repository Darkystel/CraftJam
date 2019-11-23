extends TextureButton

var inventory
var item
var index := 0

signal item_pressed(item, index)

func initialize(inv, indx):
	inventory = inv
	index = indx
	if index < inventory.items.size():
		item = inventory.items[index]
		update_texture()
	inventory.connect("inventory_changed", self, "inventory_changed")
	print("initialized")

func inventory_changed():
	print("inventory changed")
	if index < inventory.items.size():
		item = inventory.items[index]
		update_texture()
	else:
		clear_texture()

func update_texture():
	$item_texture.texture = item.item_texture

func clear_texture():
	$item_texture.texture = null

func _on_item_pressed():
	emit_signal("item_pressed", item, index)
