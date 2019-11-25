extends GridContainer

signal item_clicked(item,index)

func item_click(item, index):
	emit_signal("item_clicked", item, index)