extends Area2D

@export var siguienteNivel : String

func _on_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file(siguienteNivel)
