extends Area2D

onready var dialogue_overlay = get_parent().get_dialogue_overlay()

func _on_animation_area_body_entered(body):
	$AnimationPlayer.play("cutscene")

func _start_dialogue(dialogue: Dialogue):
	dialogue_overlay.start(dialogue)
	yield(dialogue_overlay,"dialogue_finished")
