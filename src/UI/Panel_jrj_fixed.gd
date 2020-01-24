extends Panel


onready var item = get_node("..")
var rows = [false,false,false,false,false,false,false,false,false]
onready var items = [$item1,$item2,$item3,$item4,$item5,$item6,$item7,$item8,$item9]
onready var updateditem = [item.row11,item.row12,item.row13,item.row21,item.row22,item.row23,item.row31,item.row32,item.row33]



## BOOLEANS ##
var atItem = false
var swap = false

## INT ##
var position := 0


## RESPURCES ##
var item_inside_row
var item_dragged
var item_new_found


func _physics_process(delta):
	update_items()
	if Input.is_action_pressed("mouse_left"):
		if item_inside_row != null:
			pickitem()
		
	elif Input.is_action_just_released("mouse_left"):
		if item_dragged != null:
			swap = true
		default_positions()
	elif swap:
		if item_inside_row == null and item_dragged != null:
			print(position)
			swap_empty(item_dragged)
		elif item_inside_row != null:
			print(position)
			swap(item_dragged,item_inside_row)
		
		

func pickitem():
	for i in range(0,9):
		if rows[i]:
			item_dragged = updateditem[i]
			swap = true
			position = i
			items[i].rect_position = get_local_mouse_position()


func _on_item1_mouse_entered():
	$item1.select(0)
	rows[0] = true
	if item.row11 != null:
		item_inside_row = item.row11
		print(item_inside_row.name)
	

		

func _on_item2_mouse_entered():
	rows[1] = true
	$item2.select(0)
	if item.row12 != null:
		item_inside_row = item.row12
		print(item_inside_row.name)

func _on_item3_mouse_entered():
	$item3.select(0)
	rows[2] = true
	if item.row13 != null:
		item_inside_row = item.row13
		print(item_inside_row.name)
		
func _on_item4_mouse_entered():
	rows[3] = true
	$item4.select(0)
	if item.row21 != null:
		item_inside_row = item.row21
		print(item_inside_row.name)
		
func _on_item5_mouse_entered():
	rows[4] = true
	$item5.select(0)
	if item.row22 != null:
		item_inside_row = item.row22
		print(item_inside_row.name)
		
func _on_item6_mouse_entered():
	rows[5] = true
	$item6.select(0)
	if item.row23 != null:
		item_inside_row = item.row23
		print(item_inside_row.name)
		
func _on_item7_mouse_entered():
	rows[6] = true
	$item7.select(0)
	if item.row31 != null:
		item_inside_row = item.row31
		print(item_inside_row.name)
		
func _on_item8_mouse_entered():
	rows[7] = true
	$item8.select(0)
	if item.row32 != null:
		item_inside_row = item.row32
		print(item_inside_row.name)
		
func _on_item9_mouse_entered():
	rows[8] = true
	$item9.select(0)
	if item.row33 != null:
		item_inside_row = item.row33
		print(item_inside_row.name)



####### EXIT FUNCTIONS
func _on_item1_mouse_exited():
	rows[0] = false
	$item1.unselect(0)
	item_inside_row = null
	pass


func _on_item2_mouse_exited():
	rows[1] = false
	$item2.unselect(0)
	item_inside_row = null
	pass

func _on_item3_mouse_exited():
	rows[2] = false
	$item3.unselect(0)
	item_inside_row = null
	pass

func _on_item4_mouse_exited():
	rows[3] = false
	$item4.unselect(0)
	item_inside_row = null
	pass

func _on_item5_mouse_exited():
	rows[4] = false
	$item5.unselect(0)
	item_inside_row = null
	pass

func _on_item6_mouse_exited():
	rows[5] = false
	$item6.unselect(0)
	item_inside_row = null
	pass
	
func _on_item7_mouse_exited():
	rows[6] = false
	$item7.unselect(0)
	item_inside_row = null
	pass

func _on_item8_mouse_exited():
	rows[7] = false
	$item8.unselect(0)
	item_inside_row = null
	pass
func _on_item9_mouse_exited():
	rows[8] = false
	$item9.unselect(0)
	item_inside_row = null
	pass


#######################################################
#              SWAP ITEMS FUNCTION                    #
#######################################################
func swap(taken_item, item_found):
	swap = false
	print(taken_item.name + " to be swapped with "+ item_found.name)
	var item1
	var item2
	var i = 0
	for i in range(0,9):
		if position == 0 and rows[i] and i != 0:
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(item_found,position)
			item.row(taken_item,i)
			item1.add_item("",item_found.icon)
			item2.add_item("",taken_item.icon)
		elif position == 1 and rows[i] and i != 1:
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(item_found,position)
			item.row(taken_item,i)
			item1.add_item("",item_found.icon)
			item2.add_item("",taken_item.icon)
		elif position == 2 and rows[i] and i != 2:
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(item_found,position)
			item.row(taken_item,i)
			item1.add_item("",item_found.icon)
			item2.add_item("",taken_item.icon)
		elif position == 3 and rows[i] and i != 3:
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(item_found,position)
			item.row(taken_item,i)
			item1.add_item("",item_found.icon)
			item2.add_item("",taken_item.icon)
		elif position == 4 and rows[i] and i != 4:
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(item_found,position)
			item.row(taken_item,i)
			item1.add_item("",item_found.icon)
			item2.add_item("",taken_item.icon)
		elif position == 5 and rows[i] and i != 5:
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(item_found,position)
			item.row(taken_item,i)
			item1.add_item("",item_found.icon)
			item2.add_item("",taken_item.icon)
		elif position == 6 and rows[i] and i != 6:
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(item_found,position)
			item.row(taken_item,i)
			item1.add_item("",item_found.icon)
			item2.add_item("",taken_item.icon)
		elif position == 7 and rows[i] and i != 7:
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(item_found,position)
			item.row(taken_item,i)
			item1.add_item("",item_found.icon)
			item2.add_item("",taken_item.icon)
		elif position == 8 and rows[i] and i != 8:
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(item_found,position)
			item.row(taken_item,i)
			item1.add_item("",item_found.icon)
			item2.add_item("",taken_item.icon)
	i = 0
	item_dragged = null

func swap_empty(taken_item):
	swap = false
	print(taken_item.name + " to be swapped with empty space")
	var item1
	var item2
	var i = 0
	var j = 0
	for i in range(0,9):
		j = i + 1
		if position == 0 and rows[i] and i != 0:
			print("Swapping row11 with row " + String(j))
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(null,position)
			item.row(taken_item,i)
			item1.remove_item(0)
			item2.add_item("",taken_item.icon)
		elif position == 1 and rows[i] and i != 1:
			print("Swapping row12 with row " + String(j))
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(null,position)
			item.row(taken_item,i)
			item1.remove_item(0)
			item2.add_item("",taken_item.icon)
		elif position == 2 and rows[i] and i != 2:
			print("Swapping row13 with row " + String(j))
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(null,position)
			item.row(taken_item,i)
			item1.remove_item(0)
			item2.add_item("",taken_item.icon)
		elif position == 3 and rows[i] and i != 3:
			print("Swapping row21 with row " + String(j))
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(null,position)
			item.row(taken_item,i)
			item1.remove_item(0)
			item2.add_item("",taken_item.icon)
		elif position == 4 and rows[i] and i != 4:
			print("Swapping row22 with row " + String(j))
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(null,position)
			item.row(taken_item,i)
			item1.remove_item(0)
			item2.add_item("",taken_item.icon)
		elif position == 5 and rows[i] and i != 5:
			print("Swapping row23 with row " + String(j))
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(null,position)
			item.row(taken_item,i)
			item1.remove_item(0)
			item2.add_item("",taken_item.icon)
		elif position == 6 and rows[i] and i != 6:
			print("Swapping row31 with row " + String(j))
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(null,position)
			item.row(taken_item,i)
			item1.remove_item(0)
			item2.add_item("",taken_item.icon)
		elif position == 7 and rows[i] and i != 7:
			print("Swapping row32 with row " + String(j))
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(null,position)
			item.row(taken_item,i)
			item1.remove_item(0)
			item2.add_item("",taken_item.icon)
		elif position == 8 and rows[i] and i != 8:
			print("Swapping row33 with row " + String(j))
			item1 = items[position]
			item2 = items[i]
			item1.clear()
			item2.clear()
			item.row(null,position)
			item.row(taken_item,i)
			item1.remove_item(0)
			item2.add_item("",taken_item.icon)
	i = 0
	item_dragged = null







### other static functions ###
func update_items():
	updateditem[0] = item.row11
	updateditem[1] = item.row12
	updateditem[2] = item.row13
	updateditem[3] = item.row21
	updateditem[4] = item.row22
	updateditem[5] = item.row23
	updateditem[6] = item.row31
	updateditem[7] = item.row32
	updateditem[8] = item.row33
	
func default_positions():
	$item1.rect_position = Vector2(4,3)
	$item2.rect_position = Vector2(31,3)
	$item3.rect_position = Vector2(58,3)
	$item4.rect_position = Vector2(4,30)
	$item5.rect_position = Vector2(31,30)
	$item6.rect_position = Vector2(58,30)
	$item7.rect_position = Vector2(4,57)
	$item8.rect_position = Vector2(31,57)
	$item9.rect_position = Vector2(58,57)
	