extends Area2D
class_name NPC

####################################
onready var environment = get_parent() as LevelManager
onready var player = environment.get_player() as Player
onready var dialogue_overlay = environment.get_dialogue_overlay() as DialogueOverlay
####################################
export(Dictionary) var dialogue = {
	"start_dialogue": {
		"dialogue_list": [],
		"item_to_give": null
	},
	"after_item_dialogue": {
		"dialogue_list": [],
	},
	"item_fail_dialogue": {
		"dialogue_list": null
	},
	"exhausted_dialogue": {
		"dialogue_list": null
	}
}

var in_range := false

func _on_npc_body_entered(body):
	if body.is_in_group("player"):
		in_range = true

func _on_npc_body_exited(body):
	if body.is_in_group("player"):
		in_range = false

func _unhandled_input(event):
	if event.is_action_pressed("interact") and in_range:
		_look_at_player()
		_start_dialogue()

func _look_at_player():
	if to_global(player.position).x > to_global(position).x:
		$character.flip_h = false
	else:
		$character.flip_h = true

func _start_dialogue():
	for dialogue in dialogue['start_dialogue']:
		if dialogue is Dialogue:
			print(dialogue.dialogue_list.back())





























