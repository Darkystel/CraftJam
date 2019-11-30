extends Node

var loader
var wait_frames
var time_max = 100 # msec
var current_scene

var loading_screen = "res://src/UI/main_screen_ui/loading_screen.tscn"

signal finished_loading(resource)

func _ready():
	set_process(false)

func load_resource(path): # game requests to switch to this scene
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		push_error("Loader is null")
		return
	set_process(true)
	get_tree().change_scene(loading_screen)
	wait_frames = 1

func _process(time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	if wait_frames > 0: # wait for frames to let the "loading" animation show up
		wait_frames -= 1
		return

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control for how long we block this thread

        # poll your loader
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finished loading.
			var resource = loader.get_resource()
			loader = null
			emit_signal("finished_loading", resource)
			set_process(false)
			break
		elif err == OK:
			update_progress()
		else: # error during loading
			push_error("Failed to load resource")
			loader = null
			break

func update_progress():
	print(str(loader.get_stage()) + ' / ' + str(loader.get_stage_count()))


