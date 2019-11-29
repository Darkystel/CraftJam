extends Control
class_name DialogueOverlay

export(float,10,800) var speed = 180

var dialogue_stack: Array
var current_dialogue: Array
var dialogue_displayed := false

#######################################
onready var dialogue_RLT = $Panel2/dialogue
#######################################

signal dialogue_finished

func _ready():
	$Timer.wait_time = 1/speed

func start(dialogue: Dialogue):
	get_tree().paused = true
	dialogue_stack = dialogue.dialogue_list.duplicate()
	Global.push_to_history(dialogue)
	$AnimationPlayer.play("pop_up")
	yield($AnimationPlayer, "animation_finished")
	start_dialogue()

func start_dialogue():
	dialogue_displayed = false
	var dialogue = dialogue_stack.pop_front()
	for character in dialogue:
		current_dialogue.push_back(character)
	dialogue_RLT.clear()
	$Timer.start()

func pop_character():
	dialogue_RLT.text += current_dialogue.pop_front()
	if current_dialogue.empty():
		$Timer.stop()
		dialogue_displayed = true

func _unhandled_input(event):
	if event.is_pressed() and dialogue_displayed:
		if not dialogue_stack.empty():
			start_dialogue()
		else:
			get_tree().paused = false
			$AnimationPlayer.play("go_down")
			dialogue_RLT.clear()
			dialogue_displayed = false
			emit_signal("dialogue_finished")

