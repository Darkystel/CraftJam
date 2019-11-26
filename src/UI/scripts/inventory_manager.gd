extends Overlay

onready var tab_container = $tabs

func _ready():
	$AnimationPlayer.play("appear")
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("escape") or event.is_action_pressed("inventory"):
		get_tree().paused = false
		var flush_info = flush_leftovers()
		if not flush_info.dropped_pouch.items.empty():
			drop_pouch(flush_info.dropped_pouch)
		$AnimationPlayer.play("disappear")
		get_UI_controller().pop_overlay()

func drop_pouch(dropped_pouch: DroppedPouch):
	var pouch = load("res://src/tools/dropped_pouch.tscn").instance()
	get_environment().add_child(pouch)
	pouch.dropped_pouch = dropped_pouch
	pouch.position = get_logic_root().position

func flush_leftovers() -> UIFlushInfo: #Handle leftover processes by the player
	var flush_info
	for child in tab_container.get_children():
		var obj = child.flush_leftovers()
		if obj != null and obj is UIFlushInfo:
			flush_info = obj
	return flush_info