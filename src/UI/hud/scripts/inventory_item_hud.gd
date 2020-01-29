extends TextureButton

var item: Item
var index := 0

signal item_pressed(item)

func pass_item(item) -> bool:
	if item != null:
		self.item = item
		update_texture()
		return true
	else: return false

func _on_item_pressed():
	if item != null:
		emit_signal("item_pressed", item)
	else:
		print("Slot is empty")

func update_texture():
	print('test')
	$item_texture.texture = item.item_texture
