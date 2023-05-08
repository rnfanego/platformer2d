class_name StateMachine
extends Node

signal cambioEstado(nombre_estado)

@export var estado_inicial := NodePath()

@onready var state : State = get_node(estado_inicial)
