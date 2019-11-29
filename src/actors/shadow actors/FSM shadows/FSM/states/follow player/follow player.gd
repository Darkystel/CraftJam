extends "res://addons/net.kivano.fsm/content/FSMState.gd";
################################### R E A D M E ##################################
# For more informations check script attached to FSM node
#
#

##################################################################################
#####  Variables (Constants, Export Variables, Node Vars, Normal variables)  #####
######################### var myvar setget myvar_set,myvar_get ###################
onready var player = get_node("../../../../player")
onready var vision = get_node("../../../detectors/vision")
onready var ground = get_node("../../../detectors/ground")
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
	print('follow player state')
	print(player.position)
	getLogicRoot().play_animation("walk")
	print(getLogicRoot().environment.get_player().position)
	pass

#when updating state, paramx can be used only if updating fsm manually
func update(deltaTime, param0=null, param1=null, param2=null, param3=null, param4=null):
	follow()
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
func follow():
	vision.look_at(Vector2(player.position.x,player.position.y-8))
	if getLogicRoot().environment.get_player().position.x < getLogicRoot().position.x:
		wall.left()
		sense.left()
		ground.left()
		getLogicRoot().sprite().flip_h = true
		#getLogicRoot().look_left()
	elif getLogicRoot().environment.get_player().position.x > getLogicRoot().position.x:
		wall.right()
		sense.right()
		ground.right()
		getLogicRoot().sprite().flip_h = false
		#getLogicRoot().look_right()
	if (vision.is_colliding() and vision.get_collider().is_in_group("player")):
		var direction = getLogicRoot().position.direction_to(getLogicRoot().environment.get_player().position)
		getLogicRoot().velocity.x = direction.x * getLogicRoot().movement_speed
##################################################################################
#########                         Inner Methods                          #########
##################################################################################

##################################################################################
#########                         Inner Classes                          #########
##################################################################################
