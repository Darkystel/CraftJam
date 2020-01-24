extends GridContainer


func _ready():
	_initgrid()
	


func _initgrid():
	set_columns(3)
	for i in range(0, 8):
		var icon = load("res://src/UI/grid.tscn")
		add_child(icon.instance())