extends Node

var parallax_layer_data = {
	"The Altar": {
		"positions": [],
		"scales": []
	},
	"The Oustskirts": {
		"positions": [],
		"scales": []
	},
	"Caves of Sin": {
		"positions": [],
		"scales": []
	}
}

func get_layer_positions(area_name: String) -> PoolVector2Array:
	return parallax_layer_data[area_name]['positions']
func get_layer_scales(area_name: String) -> PoolVector2Array:
	return parallax_layer_data[area_name]['scales']

func set_layer_positions(area_name: String, positions: PoolVector2Array):
	parallax_layer_data[area_name]['positions'] = positions
func set_layer_scales(area_name: String, scales: PoolVector2Array):
	parallax_layer_data[area_name]['scales'] = scales


var disable_dialogue := false
var dialogue_history = []

func push_to_history(item):
	if item is Dialogue:
		dialogue_history.push_back(item)
	else:
		push_error("GLOBAL SCRIPT: Item passed to 'push_to_history' does not have a specific history")