class_name State
extends Node

var state_machine : StateMachine = null
@export var anim_player_path : NodePath

@onready var anim_player = get_node(anim_player_path)

func state_input(_event: InputEvent):
	pass
	
func state_enter_state(msg := {}):
	pass
	
func state_process(delta):
	pass
	
func state_physics_process(delta):
	pass
	
func state_exit():
	pass
