extends Resource
class_name recipe_jrj


var row11
var row12
var row13
var row21
var row22
var row23
var row31
var row32
var row33

var no_of_items = 0


export(Array, bool)var rows = [false,false,false,false,false,false,false,false,false]
export(Array, Resource)var items = [null,null,null,null,null,null,null,null,null]



export(Resource) var result


func check(r, items_sent: Array):
	var j = active_rows()
	var craft = 0
	if j == r:
		for i in range(0,9):
			if craft < no_of_items:
				if items[i] != null and items_sent[i] != null:
					if rows[i] and items[i].name == items_sent[i].name:
						craft = craft + 1
				
	if craft == no_of_items:
		
		return result
	else:
		return null
	
func active_rows():
	var i = 0
	no_of_items = 0
	if rows[0]:
		i = i + 0
		no_of_items = no_of_items + 1
	if rows[1]:
		i = i + 1
		no_of_items = no_of_items + 1
	if rows[2]:
		i = i + 2
		no_of_items = no_of_items + 1
	if rows[3]:
		i = i + 3
		no_of_items = no_of_items + 1
	if rows[4]:
		i = i + 4
		no_of_items = no_of_items + 1
	if rows[5]:
		i = i + 5
		no_of_items = no_of_items + 1
	if rows[6]:
		i = i + 6
		no_of_items = no_of_items + 1
	if rows[7]:
		i = i + 7
		no_of_items = no_of_items + 1
	if rows[8]:
		i = i + 8
		no_of_items = no_of_items + 1
	return i