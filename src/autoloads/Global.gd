extends Node

var disable_dialogue := false
var dialogue_history = []

func push_to_history(item):
	if item is Dialogue:
		dialogue_history.push_back(item)
	else:
		push_error("GLOBAL SCRIPT: Item passed to 'push_to_history' does not have a specific history")