extends Node2D
class_name LevelManager

export(String) var area_name = ""

onready var entrances = $entrances.get_children()
onready var limiters = $limiters.get_children()
func _ready():
	VisualServer.set_default_clear_color(Color.black)
	if area_name == "The Altar":
		$dark_environment.visible = false
		if MapHandler.spawn:
			spawn_player()
			MapHandler.spawn = false
	else:
		$dark_environment.visible = false
	for departure in $departures.get_children():
		departure.connect("player_exited_map", self, "player_exited_map")

	if MapHandler.player != null:
		put_player(MapHandler.player, MapHandler.entrance_id)
	set_limiters()
	pass

func spawn_player():
	$animation_controller.play("spawn")

func put_player(player: Player, intrance_id: int):
	remove_child(get_node("player"))
	add_child(player)
	player.position = entrances[intrance_id].position

func set_limiters():
	get_player().set_limits(limiters[1].position.x, limiters[0].position.x)

func player_exited_map(map: String, entrance_id: int):
	print(map + ' ' + str(entrance_id))
	MapHandler.go_to_map(map, entrance_id)

func get_player(remove: bool = false) -> Player:
	var player = get_node("player")
	if remove: remove_child(player)
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