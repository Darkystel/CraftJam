extends Node2D

enum state {UP, DOWN}


export(float) var travel_time = 4.0

export(state) var position_of_elevator = state.DOWN

onready var platform = $platform
onready var down = $Down
onready var up = $Up

var in_transit := false
var in_range := false
var platdown := false
var platup := false

func _ready():
	match position_of_elevator:
		state.UP:
			$liver_down/AnimationPlayer.play("on")
			$liver_up/AnimationPlayer.play("off")
			platup = true
			platdown = false
			platform.position = up.position
		state.DOWN:
			$liver_down/AnimationPlayer.play("off")
			$liver_up/AnimationPlayer.play("on")
			platup = false
			platdown = true
			platform.position = down.position
	

func _unhandled_input(event):
	if event.is_action_pressed("interact") and in_range and not in_transit:
		_travel()

func _travel():
	if platdown:
		platup = true
		platdown = false
		in_transit = true
		$liver_down/AnimationPlayer.play("on")
		$liver_up/AnimationPlayer.play("off")
		$interpolator.interpolate_property(platform,"position",platform.position,up.position,travel_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$interpolator.start()
		yield($interpolator,"tween_all_completed")
		in_transit = false
	elif platup:
		platup = false
		platdown = true
		in_transit = true
		$liver_up/AnimationPlayer.play("on")
		$liver_down/AnimationPlayer.play("off")
		$interpolator.interpolate_property(platform,"position",platform.position,down.position,travel_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$interpolator.start()
		yield($interpolator,"tween_all_completed")
		in_transit = false
	
	pass

func _on_liver_body_entered(body):
	if body.is_in_group("player"):
		in_range = true

func _on_liver_body_exited(body):
	if body.is_in_group("player"):
		in_range = false

func _on_Up_body_entered(body):
	print("platup = ", platup)
	print("platdown = ", platdown)
	platup = true
	platdown = false


func _on_Down_body_entered(body):
	print("platup = ", platup)
	print("platdown = ", platdown)
	platup = false
	platdown = true

func _on_Up_body_exited(body):
	platup = false
	platdown = true


func _on_Down_body_exited(body):
	platup = true
	platdown = false
