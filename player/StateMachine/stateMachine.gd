class_name StateMachine
extends Node

signal cambioEstado(nombre_estado)

@export var estado_inicial := NodePath()

@onready var state : State = get_node(estado_inicial)

func _ready():
	await (owner.ready)
	for child in get_children():
		child.state_machine = self
	state.state_enter_state()

func _process(delta):
	state.state_process(delta)
	
func _unhandled_input(event):
	state.state_input(event)
	
func _physics_process(delta):
	state.state_physics_process(delta)

func transition_to(target_state: String, msg : Dictionary = {}):
	if not has_node(target_state):
		return
		
	state.state_exit()
	state = get_node(target_state)
	state.state_enter_state(msg)

	emit_signal("cambioEstado", state.name)
