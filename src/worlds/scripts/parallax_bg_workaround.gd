extends ParallaxBackground



func _exit_tree():
	print('Exiting tree')
	var layer_positions : PoolVector2Array = []
	var layer_scales : PoolVector2Array = []
	
	for b in self.get_children():
		#add parallax layer position to the array
		layer_positions.append(b.position)
		layer_scales.append(b.scale)
	Global.set_layer_positions(get_parent().area_name, layer_positions)
	Global.set_layer_scales(get_parent().area_name, layer_scales)

func _enter_tree():
	var layer_positions : PoolVector2Array = Global.get_layer_positions(get_parent().area_name)
	var layer_scales : PoolVector2Array = Global.get_layer_scales(get_parent().area_name)
	for idx in range(0,layer_positions.size()):
		self.get_child(idx).position = layer_positions[idx]
		self.get_child(idx).scale = layer_scales[idx]