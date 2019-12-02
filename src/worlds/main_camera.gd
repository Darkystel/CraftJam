extends Camera2D


func _process(delta):
	var player = get_parent().get_player()
	if player != null:
		position.x = lerp(position.x, player.position.x, 0.9)
		position.y = lerp(position.y, player.position.y, 0.9)
