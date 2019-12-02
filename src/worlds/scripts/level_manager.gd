extends Node2D
class_name LevelManager

export(String) var area_name = ""

onready var entrances = $entrances.get_children()
onready var limiters = $limiters.get_children()
func _ready():
	$dark_environment.visible = true
	VisualServer.set_default_clear_color(Color.black)
	put_player(MapHandler.player, MapHandler.entrance_id)
	for departure in $departures.get_children():
		departure.connect("player_exited_map", self, "player_exited_map")
	if Global.disable_dialogue:
		for dialogue_node in get_tree().get_nodes_in_group("dialogue"):
			dialogue_node.queue_free()
	if area_name == "The Altar":
		print("The Altar map loaded:-")
		for layer in $ParallaxBackground.get_children():
			print("Layer position : " + str(layer) + " " + str(layer.position))
			print("Layer scale : " + str(layer) + " " + str(layer.scale))
			for sprite in layer.get_children():
				print("Sprite position : " + str(sprite) + " " + str(sprite.position))
				print("Sprite scale : " + str(sprite) + " " + str(sprite.scale))

func put_player(player: Player, entrance_id: int = -1):
	print(entrance_id)
	remove_child(get_node("player"))
	add_child(player)
	player.set_limits(limiters[1].position.x, limiters[0].position.x)
	print('Entrance id = ' + str(entrance_id))
	if get_entrance(entrance_id) != null:
		player.position = get_entrance(entrance_id).position
	else:
		player.position = Vector2(0,0)

func get_entrance(entrance_id: int) -> Position2D:
	for child in $entrances.get_children():
		if child is Position2D:
			if child.entrance_id == entrance_id:
				return child
	push_error("Failed to find entrance, number of entrances : " + str($entrances.get_child_count()))
	return null

func set_limiters():
	get_player().set_limits(limiters[1].position.x, limiters[0].position.x)

func player_exited_map(map: String, entrance_id: int):
	MapHandler.entrance_id = entrance_id
	MapHandler.go_to_map(map, entrance_id)
	for node in get_tree().get_nodes_in_group("npcs"):
		node.queue_free()

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