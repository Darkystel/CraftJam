extends Control

func set_percent(percent: float, max_percent: float = 100.0):
	var third = max_percent/3
	var value = 0 if percent == 0 else 2 if percent < third else 4 if percent < 2*third else 6
	print(percent)
	print(value)
	$battery.value = value
	$battery.tint_progress = Color.green if value == 6 else Color.yellow if value == 4 else Color.red