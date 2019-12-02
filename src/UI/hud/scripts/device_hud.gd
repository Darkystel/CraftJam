extends Control

func set_percent(percent: float, max_percent: float = 100.0):
	var v = 1 + percent * 5.0 / 100.0
	$battery.value = v
	$battery.tint_progress = Color.green if percent > 66 else Color.yellow if percent > 33 else Color.red