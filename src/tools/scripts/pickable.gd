extends Area2D

export(Resource) var item = null

var pickable = false
var player = null

func _ready():
	assert(item != null)
#	if item is Item:
#		item = copy_item(item)
#	else:
#		push_error("Resource passed to item property is not of type Item")

func _on_pickable_body_entered(body):
	if body.is_in_group("player"): 
		pickable = true
		player = body

func _on_pickable_body_exited(body):
	if body.is_in_group("player"): 
		pickable = false
		player = body

func _unhandled_input(event):
	if event.is_action_pressed("interact") and pickable:
		if player.pick_up_item(item):
			queue_free()

func copy_item(to_be_coppied: Item) -> Item:
	var item = Item.new()
	item.name = to_be_coppied.name
	item.description = to_be_coppied.description
	item.types = to_be_coppied.types
	item.item_texture = to_be_coppied.item_texture
	item.item_scene = to_be_coppied.item_scene
	return item