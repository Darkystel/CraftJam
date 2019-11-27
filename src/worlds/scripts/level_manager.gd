extends Node2D
class_name LevelManager

func get_player() -> Player:
	var player = get_node("player")
	if player is Player:
		return player
	else:
		push_error("Player is not added to the level")
		return null