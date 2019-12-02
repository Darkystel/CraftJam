extends Node2D

export(bool) var requires_special_key = false
var player

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		if player != null:
			var inv = player.inventory as Inventory
			if inv.consume_key(requires_special_key):
				$AnimationPlayer.play("open")
			else:
				var d_ol = get_parent().get_dialogue_overlay()
				var d = Dialogue.new()
				d.protagonist_name = "You"
				d.protagonist_texture = null
				if requires_special_key:
					d.dialogue_list.push_back("Requires a special key of some kind..")
				else:
					d.dialogue_list.push_back("Requires key..")
				d_ol.start(d)

func _on_aoe_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_aoe_body_exited(body):
	if body.is_in_group("player"):
		player = null
