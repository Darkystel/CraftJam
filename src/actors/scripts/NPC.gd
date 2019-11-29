extends Area2D
class_name NPC

####################################
onready var environment = get_parent() as LevelManager
onready var player = environment.get_player() as Player
onready var dialogue_overlay = environment.get_dialogue_overlay() as DialogueOverlay
####################################
export(Array, Resource) var start_dialogue
export(Array, Resource) var exhaust_dialogue
var exhausted

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
	for dialogue in start_dialogue:
		dialogue_overlay.start(dialogue)
		yield(dialogue_overlay,"dialogue_finished")





























