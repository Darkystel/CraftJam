extends Resource
class_name SenseData

var wall_sense : bool
var ground_sense : bool

func obstacle_encounter() -> bool: return wall_sense or not ground_sense