extends IMTabs

##########################################
onready var dialogue_history_list = $dialogue_history
##########################################
func _ready():
	for dialogue in Global.dialogue_history:
		var display_dialogue: String = dialogue.antagonist_name + ":-\n"
		for sentence in dialogue.dialogue_list:
			display_dialogue += sentence
		dialogue_history_list.add_item(display_dialogue)