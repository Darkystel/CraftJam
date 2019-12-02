extends Node


func _on_enemy3_enemy_died():
	get_tree().change_scene("res://src/UI/screens/game_finished.tscn")
