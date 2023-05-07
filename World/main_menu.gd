extends Node



func _on_start_pressed():
	get_tree().change_scene_to_file("res://World/world.tscn")
	
	


func _on_exit_pressed():
	get_tree().quit()


func _on_fullscreen_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
