extends Resource
class_name recipe_jrj

var no_of_items = 0
var no_of_items2 = 0
var no_of_items3 = 0
var no_of_items4 = 0
var no_of_items5 = 0
var no_of_items6 = 0


#########################################################
#####     ROWS ORDER FOR THE TRUE, FALSE VALUES     #####
#########################################################
#####         0     |        1        |      2      #####      
#####         3     |        4        |      5      #####    
#####         6     |        7        |      8      #####    
#########################################################
#########################################################
#####     ROW11     |      ROW12      |    ROW13    #####      
#####     ROW21     |      ROW22      |    ROW23    #####     
#####     ROW31     |      ROW32      |    ROW33    #####    
#########################################################
#####  Please select which slot needed so the item  #####
#####  Can be crafted  (e.g rows[4] and rows[6])    #####
#####  (rows2[3] and rows2[1])  for rows2           #####
#####  (rows3[7] and rows3[5])  for rows3           #####
#####  (rows4[4] and rows4[2])  for rows4           #####
#####  so now if 2 items combination in 6 and 4     #####
#####  can craft the item needed or in 3 and 1, etc #####
#########################################################


 
export(Array, bool)var rows = [false,false,false,false,false,false,false,false,false]

# rows2,3,4 are added so the crafting table can find the combination in any slot instead of making more than 1 recipe for the same item
export(Array, bool)var rows2 = [false,false,false,false,false,false,false,false,false]
export(Array, bool)var rows3 = [false,false,false,false,false,false,false,false,false]
export(Array, bool)var rows4 = [false,false,false,false,false,false,false,false,false]
export(Array, bool)var rows5 = [false,false,false,false,false,false,false,false,false]
export(Array, bool)var rows6 = [false,false,false,false,false,false,false,false,false]



export(Array, Resource)var items = [null,null,null,null,null,null,null,null,null]

# items2,3,4 are added so the crafting table can find the combination in any slot instead of making more than 1 recipe for the same item

export(Array, Resource)var items2 = [null,null,null,null,null,null,null,null,null]
export(Array, Resource)var items3 = [null,null,null,null,null,null,null,null,null]
export(Array, Resource)var items4 = [null,null,null,null,null,null,null,null,null]
export(Array, Resource)var items5 = [null,null,null,null,null,null,null,null,null]
export(Array, Resource)var items6 = [null,null,null,null,null,null,null,null,null]



export(Resource) var result


func check(r, items_sent: Array):
	var r1 = active_rows()
	var r2 = active_rows2()
	var r3 = active_rows3()
	var r4 = active_rows4()
	var r5 = active_rows5()
	var r6 = active_rows6()
	var craft = 0
	if r1 == r:
		for i in range(0,9):
			if craft < no_of_items:
				if items[i] != null and items_sent[i] != null:
					if rows[i] and items[i].name == items_sent[i].name:
						craft = craft + 1
	elif r2 == r:
		for i in range(0,9):
			if craft < no_of_items2:
				if items2[i] != null and items_sent[i] != null:
					if rows2[i] and items2[i].name == items_sent[i].name:
						craft = craft + 1
	elif r3 == r:
		for i in range(0,9):
			if craft < no_of_items3:
				if items3[i] != null and items_sent[i] != null:
					if rows3[i] and items3[i].name == items_sent[i].name:
						craft = craft + 1
	elif r4 == r:
		for i in range(0,9):
			if craft < no_of_items4:
				if items4[i] != null and items_sent[i] != null:
					if rows4[i] and items4[i].name == items_sent[i].name:
						craft = craft + 1
	elif r5 == r:
		for i in range(0,9):
			if craft < no_of_items5:
				if items5[i] != null and items_sent[i] != null:
					if rows5[i] and items5[i].name == items_sent[i].name:
						craft = craft + 1
	elif r6 == r:
		for i in range(0,9):
			if craft < no_of_items6:
				if items6[i] != null and items_sent[i] != null:
					if rows6[i] and items6[i].name == items_sent[i].name:
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
	
func active_rows2():
	var i = 0
	no_of_items2 = 0
	if rows2[0]:
		i = i + 0
		no_of_items2 = no_of_items2 + 1
	if rows2[1]:
		i = i + 1
		no_of_items2 = no_of_items2 + 1
	if rows2[2]:
		i = i + 2
		no_of_items2 = no_of_items2 + 1
	if rows2[3]:
		i = i + 3
		no_of_items2 = no_of_items2 + 1
	if rows2[4]:
		i = i + 4
		no_of_items2 = no_of_items2 + 1
	if rows2[5]:
		i = i + 5
		no_of_items2 = no_of_items2 + 1
	if rows2[6]:
		i = i + 6
		no_of_items2 = no_of_items2 + 1
	if rows2[7]:
		i = i + 7
		no_of_items2 = no_of_items2 + 1
	if rows2[8]:
		i = i + 8
		no_of_items2 = no_of_items2 + 1
	return i
	
func active_rows3():
	var i = 0
	no_of_items3 = 0
	if rows3[0]:
		i = i + 0
		no_of_items3 = no_of_items3 + 1
	if rows3[1]:
		i = i + 1
		no_of_items3 = no_of_items3 + 1
	if rows3[2]:
		i = i + 2
		no_of_items3 = no_of_items3 + 1
	if rows3[3]:
		i = i + 3
		no_of_items3 = no_of_items3 + 1
	if rows3[4]:
		i = i + 4
		no_of_items3 = no_of_items3 + 1
	if rows3[5]:
		i = i + 5
		no_of_items3 = no_of_items3 + 1
	if rows3[6]:
		i = i + 6
		no_of_items3 = no_of_items3 + 1
	if rows3[7]:
		i = i + 7
		no_of_items3 = no_of_items3 + 1
	if rows3[8]:
		i = i + 8
		no_of_items3 = no_of_items3 + 1
	return i
	
func active_rows4():
	var i = 0
	no_of_items4 = 0
	if rows4[0]:
		i = i + 0
		no_of_items4 = no_of_items4 + 1
	if rows4[1]:
		i = i + 1
		no_of_items4 = no_of_items4 + 1
	if rows4[2]:
		i = i + 2
		no_of_items4 = no_of_items4 + 1
	if rows4[3]:
		i = i + 3
		no_of_items4 = no_of_items4 + 1
	if rows4[4]:
		i = i + 4
		no_of_items4 = no_of_items4 + 1
	if rows4[5]:
		i = i + 5
		no_of_items4 = no_of_items4 + 1
	if rows4[6]:
		i = i + 6
		no_of_items4 = no_of_items4 + 1
	if rows4[7]:
		i = i + 7
		no_of_items4 = no_of_items4 + 1
	if rows4[8]:
		i = i + 8
		no_of_items4 = no_of_items4 + 1
	return i
	
func active_rows5():
	var i = 0
	no_of_items5 = 0
	if rows4[0]:
		i = i + 0
		no_of_items5 = no_of_items5 + 1
	if rows4[1]:
		i = i + 1
		no_of_items5 = no_of_items5 + 1
	if rows4[2]:
		i = i + 2
		no_of_items5 = no_of_items5 + 1
	if rows4[3]:
		i = i + 3
		no_of_items5 = no_of_items5 + 1
	if rows4[4]:
		i = i + 4
		no_of_items5 = no_of_items5 + 1
	if rows4[5]:
		i = i + 5
		no_of_items5 = no_of_items5 + 1
	if rows4[6]:
		i = i + 6
		no_of_items5 = no_of_items5 + 1
	if rows4[7]:
		i = i + 7
		no_of_items5 = no_of_items5 + 1
	if rows4[8]:
		i = i + 8
		no_of_items5 = no_of_items5 + 1
	return i
	
func active_rows6():
	var i = 0
	no_of_items6 = 0
	if rows4[0]:
		i = i + 0
		no_of_items6 = no_of_items6 + 1
	if rows4[1]:
		i = i + 1
		no_of_items6 = no_of_items6 + 1
	if rows4[2]:
		i = i + 2
		no_of_items6 = no_of_items6 + 1
	if rows4[3]:
		i = i + 3
		no_of_items6 = no_of_items6 + 1
	if rows4[4]:
		i = i + 4
		no_of_items6 = no_of_items6 + 1
	if rows4[5]:
		i = i + 5
		no_of_items6 = no_of_items6 + 1
	if rows4[6]:
		i = i + 6
		no_of_items6 = no_of_items6 + 1
	if rows4[7]:
		i = i + 7
		no_of_items6 = no_of_items6 + 1
	if rows4[8]:
		i = i + 8
		no_of_items6 = no_of_items6 + 1
	return i