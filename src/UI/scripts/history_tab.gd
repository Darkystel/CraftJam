extends IMTabs

##########################################
onready var dialogue_history = $dialogue_history/history
##########################################
func _ready():
	for dialogue in Global.dialogue_history:
		var display_dialogue: String = ""
		for sentence in dialogue.dialogue_list:
			display_dialogue += dialogue.protagonist_name + ": " + sentence + "\n"
		dialogue_history.text += display_dialogue