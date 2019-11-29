extends "res://addons/net.kivano.fsm/content/FSMState.gd";
################################### R E A D M E ##################################
# For more informations check script attached to FSM node
#
#

##################################################################################
#####  Variables (Constants, Export Variables, Node Vars, Normal variables)  #####
######################### var myvar setget myvar_set,myvar_get ###################
signal not_caught
signal caught

var last_location_seen = Vector2(0,0)
var not_found = false

onready var vision = get_node("../../../detectors/vision")
onready var sense = get_node("../../../detectors/sense")
onready var wall = get_node("../../../detectors/wall")
##################################################################################
#########                       Getters and Setters                      #########
##################################################################################
#you will want to use those
func getFSM(): return fsm; #defined in parent class
func getLogicRoot(): return logicRoot; #defined in parent class 

##################################################################################
#########                 Implement those below ancestor                 #########
##################################################################################
#you can transmit parameters if fsm is initialized manually
func stateInit(inParam1=null,inParam2=null,inParam3=null,inParam4=null, inParam5=null): 
	pass

#when entering state, usually you will want to reset internal state here somehow
func enter(fromStateID=null, fromTransitionID=null, inArg0=null,inArg1=null, inArg2=null):
	print('Looking for player state')
	getLogicRoot().play_animation("idle")
	last_location_seen = getLogicRoot().environment.get_player().position
	print(last_location_seen)
	#vision.rotation_degrees = 0
	#if last_location_seen.x < getLogicRoot().position.x:
		#vision.left()
	
	
	pass

#when updating state, paramx can be used only if updating fsm manually
func update(deltaTime, param0=null, param1=null, param2=null, param3=null, param4=null):
	search()
	pass

#when exiting state
func exit(toState=null):
	pass

##################################################################################
#########                       Connected Signals                        #########
##################################################################################

##################################################################################
#########     Methods fired because of events (usually via Groups interface)  ####
##################################################################################

##################################################################################
#########                         Public Methods                         #########
##################################################################################
func search():	
	update_vision()
	var direction = getLogicRoot().position.direction_to(last_location_seen)
	getLogicRoot().velocity.x = direction.x * getLogicRoot().movement_speed
	if getLogicRoot().position.x < last_location_seen.x:
		if (vision.is_colliding() and vision.get_collider().is_in_group("player")) or (sense.is_colliding() and sense.get_collider().is_in_group("player")):
			emit_signal("caught")
		elif getLogicRoot().position.x >= last_location_seen.x-1 or wall.is_colliding():
			emit_signal("not_caught")
	elif getLogicRoot().position.x > last_location_seen.x:
		if (vision.is_colliding() and vision.get_collider().is_in_group("player")) or (sense.is_colliding() and sense.get_collider().is_in_group("player")):
			emit_signal("caught")
		elif getLogicRoot().position.x <= last_location_seen.x-1 or wall.is_colliding():
			emit_signal("not_caught")
			
			
func update_vision():
	if last_location_seen.x < getLogicRoot().position.x:
		vision.rotation_degrees = 180
	elif last_location_seen.x > getLogicRoot().position.x:
		vision.rotation_degrees = 0
		#getLogicRoot().look_right()
##################################################################################
#########                         Inner Methods                          #########
##################################################################################

##################################################################################
#########                         Inner Classes                          #########
##################################################################################
