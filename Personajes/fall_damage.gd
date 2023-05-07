extends Area2D

func _on_body_entered(body):
	if body is Player:
		body.takeDmg(9999)
