extends Area2D

export(Resource) var dialogue

func _ready():
	pass


func _on_dialogue_aoe_body_entered(body):
	if body.is_in_group("player"):
		get_parent().get_dialogue_overlay().start(dialogue)
		yield(get_parent().get_dialogue_overlay(),"dialogue_finished")
		queue_free()