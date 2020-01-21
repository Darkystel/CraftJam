extends Node2D

onready var player = get_node("../player")
onready var fromS = get_node("From/FromS")
onready var toS = get_node("To/ToS")

var in_range = false
var from = false
var to = false
var tp = true


export var travel_time = 0.5
export var body_pulled_to_gate_time = 0.5
export var scale_time = 0.4

func _on_From_body_entered(body):
	if body.is_in_group("player"):
		fromS.play("absorb")
		in_range = true
		from = true


func _on_To_body_entered(body):
	if body.is_in_group("player"):
		toS.play("absorb")
		in_range = true
		to = true
	
	
		
func _unhandled_input(event):
	if event.is_action_pressed("interact") and in_range:
		teleport()
		
func teleport():
	if to and tp:
		tp = false
		$Tween.interpolate_property(player,"position",player.global_position,$To.global_position,body_pulled_to_gate_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.interpolate_property(player,"scale",Vector2(1,1),Vector2(0,0),scale_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween,"tween_all_completed")
		$Tween.interpolate_property(player,"position",$To.global_position,$From.global_position,travel_time,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween,"tween_all_completed")
		$Tween.interpolate_property(player,"position",player.global_position,$From.global_position,body_pulled_to_gate_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.interpolate_property(player,"scale",Vector2(0,0),Vector2(1,1),scale_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween,"tween_all_completed")
		player.velocity.y = 0
		tp = true
		#player.position = $From.global_position
	elif from and tp:
		tp = false
		$Tween.interpolate_property(player,"position",player.global_position,$From.global_position,body_pulled_to_gate_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.interpolate_property(player,"scale",Vector2(1,1),Vector2(0,0),0.2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween,"tween_all_completed")
		$Tween.interpolate_property(player,"position",$From.global_position,$To.global_position,travel_time,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween,"tween_all_completed")
		$Tween.interpolate_property(player,"position",player.global_position,$To.global_position,body_pulled_to_gate_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.interpolate_property(player,"scale",Vector2(0,0),Vector2(1,1),0.2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween,"tween_all_completed")
		player.velocity.y = 0
		tp = true

func _on_From_body_exited(body):
	if body.is_in_group("player"):
		fromS.play("done")
		in_range = false
		from = false
	


func _on_To_body_exited(body):
	if body.is_in_group("player"):
		toS.play("done")
		in_range = false
		to = false


func _on_FromS_animation_finished():
	if fromS.get_animation() == "absorb":
		fromS.play("teleporting")
		
	elif fromS.get_animation() == "done":
		fromS.play("idle")
	pass


func _on_ToS_animation_finished():
	if toS.get_animation() == "absorb":
		toS.play("teleporting")
		
	elif toS.get_animation() == "done":
		toS.play("idle")
	
	pass
