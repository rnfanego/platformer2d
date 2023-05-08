@tool
extends Node

var dmg := 1

@onready var sprite = $SierraVerdadera/Sprite
@onready var sierra = $SierraVerdadera
@onready var pathFollow = $Path2D/PathFollow2D
@export var speed := .2

func _process(delta):
	if not Engine.is_editor_hint():
		sprite.rotate(deg_to_rad(300*delta))
		
		sierra.global_position = pathFollow.global_position
		
		if pathFollow.progress_ratio < 1:
			pathFollow.progress_ratio += speed * delta
		else:
			pathFollow.progress_ratio = 0

func _on_dmg_player_body_entered(body):
	if body is Player:
		body.takeDmg(dmg)
