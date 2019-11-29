extends Node2D
class_name LevelManager

export(String) var area_name = ""
export(Color) var background_color = Color.black
export(bool) var player_light = true


func _ready():
	VisualServer.set_default_clear_color(background_color)
	if not player_light:
		get_player().set_light_energy(0.0)
	if area_name == "Altar":
		$animation_controller.play("spawn")
		$dark_environment.visible = false
	else:
		$dark_environment.color = Color.black
		$dark_environment.visible = true
	get_player().set_limits($limiters/limit_left.position.x, $limiters/limit_right.position.x)
	

func get_player() -> Player:
	var player = get_node("player")
	if player is Player:
		return player
	else:
		push_error("Player is not added to the level")
		return null

func get_dialogue_overlay() -> DialogueOverlay:
	var dialogue_overlay = get_node("overlay/dialogue_overlay")
	if dialogue_overlay is DialogueOverlay:
		return dialogue_overlay
	else:
		push_error("Dialogue Overlay is not added to the level")
		return null