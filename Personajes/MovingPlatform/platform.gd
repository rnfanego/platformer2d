@tool
extends Path2D

@onready var character = $PlatformCharacter
@onready var pathFollow = $PathFollow2D
@export var platformSpeed : float = .2

func _process(delta):
	if not Engine.is_editor_hint():
		character.global_position = pathFollow.global_position
		
		if pathFollow.progress_ratio < 1:
			pathFollow.progress_ratio += platformSpeed * delta
		else:
			pathFollow.progress_ratio = 0
