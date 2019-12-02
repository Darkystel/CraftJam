extends Actor
class_name Player

var presence := 10.0
var hp := 100.0
var recover := false

export(int) var inventory_capacity = 8
export(int) var equip_capacity
var inventory: Inventory

export(float) var hp_drain = 3.1
export(float) var recovery_rate = 0.45

onready var equipments = $equipments

signal player_died

func turn_off_light(): $light.visible = false
func turn_on_light(): $light.visible = true

func damage_player():
	recover = false
	$recovery_time.stop()
	hp -= hp_drain
	if hp <= 0:
		kill_player()
	$recovery_time.start()
	$main_camera.start_shaking()

func kill_player():
	set_process(false)
	set_physics_process(false)
	emit_signal("player_died")

func force_idle():
	$character.play("idle")

func _ready(): 
	inventory = Inventory.new()
	inventory.capacity = inventory_capacity
	inventory.equip_capacity = equip_capacity
	inventory.initialize_recipes()
	set_process(true)

func set_limits(limit_left, limit_right):
	$main_camera.limit_left = limit_left
	$main_camera.limit_right = limit_right

func set_light_energy(value: float):
	$light.energy = value

func _unhandled_input(event):
	if event.is_action_pressed("test_button"):
		$main_camera.start_shaking(0.8)
	elif event.is_action_pressed("search"):
		call_out_enemies()

func call_out_enemies():
	if $call_recover.is_stopped():
		var rand = rand_range(0,1)
		if rand > 0.75: $call_sound_1.play()
		else: $call_sound_2.play()
		for enemy in get_tree().get_nodes_in_group("enemy"):
			if position.distance_to(enemy.position) <= 96.0:
				enemy.force_detect()
		$call_recover.start()
	else:
		get_parent().get_dialogue_overlay().start(load("res://src/actors/dialogue_list/player/catching_breath.tres"))

func pick_up_item(item):
	if inventory.add_to_inventory(item):
		set_physics_process(false)
		$character.play("pickup")
		yield($character, "animation_finished")
		set_physics_process(true)
		return true
	else:
		return false

func _process(delta):
	if recover:
		hp += recovery_rate
		if hp >= 100.0:
			hp = 100.0
			recover = false

func _physics_process(delta):
	var snap_vector = Vector2.DOWN * 2
	
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction < 0: $character.flip_h = true
	elif direction > 0: $character.flip_h = false
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() :
			$character.play("jump")
			velocity.y = -jumping_height
			snap_vector = Vector2.ZERO
	
	velocity.x = direction * movement_speed
	
	velocity.y += gravity
	
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP)
	if abs(velocity.x) > 0 and is_on_floor():
		$character.play("walk")
	
	elif not is_on_floor() and velocity.y > 0:
		$character.play("fall")
	elif is_on_floor():
		$character.play("idle")


func _on_recovery_time_timeout():
	recover = true


func _on_CheckBox_toggled(button_pressed):
	$main_camera.current = button_pressed
