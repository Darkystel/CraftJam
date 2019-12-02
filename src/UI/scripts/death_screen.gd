extends Control

func _ready():
	$AnimationPlayer.play("appear")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "appear": $AnimationPlayer.play("disappear")
	elif anim_name == "disappear" : MapHandler.start_new_game()
