extends ReferenceRect

func set_texture(texture: Texture):
	$item_texture.texture = texture

func clear_texture():
	$item_texture.texture = null