extends Node

var current_map: String
var entrance_id: int = -1
var player: Player = null

var spawn: bool = false

onready var MAPS: Dictionary = {
	"The Altar": 'res://src/worlds/altar.tscn',
	"The Outskirts": 'res://src/worlds/outskirts.tscn'
}


func start_new_game():
	spawn = true
	load_map("The Altar") 

func go_to_map(map: String, entrance: int):
	entrance_id = entrance
	player = get_tree().current_scene.get_player(true)
	load_map(map)

func load_map(map: String):
	get_tree().change_scene('res://src/UI/main_screen_ui/loading_screen.tscn')
	var loader = ResourceLoader.load_interactive(MAPS[map])
	if loader.wait() == ERR_FILE_EOF:
		get_tree().change_scene_to(loader.get_resource())
		current_map = map