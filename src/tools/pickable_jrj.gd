extends Area2D

onready var player

export(Resource) var item


var picked := false
var item_path = null
var item_added = false
var in_sight:= false


func _ready():
	pass

func _physics_process(delta):
	if !item_added:
		if item_path != null:
			item = load(item_path)
		item_added = true
	
	if in_sight and Input.is_action_just_pressed("interact") and player.inventory.items_collected < player.inventory.capacity:
		player.pick = true
		player.add_to_inventory(item)
		picked = true
	if picked:
		queue_free()
		

func _on_pickable_body_entered(body):
	if body.is_in_group("player"):
		player = body
		in_sight = true
		$RichTextLabel.text = " pick"
	


func _on_pickable_jrj_body_exited(body):
	if body.is_in_group("player"):
		in_sight = false
		$RichTextLabel.text = ""

func save():
	var save_dict =  {
	"filename" : get_filename(),
	"parent" : get_parent().get_path(),
	"pos_x" : position.x, # Vector2 is not supported by JSON
	"pos_y" : position.y,
	"picked" : picked,
	"item_path" : item.get_path()
	}
	return save_dict
