extends Area2D


func _on_body_entered(body):
	if body is Player:
		Global.frutas +=1
		queue_free()
