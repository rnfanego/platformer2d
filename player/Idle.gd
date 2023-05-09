extends PlayerState

func state_enter_state(msg := {}):
	player.velocity = Vector2.ZERO
	anim_player.play("idle")

func state_process(delta):
	var direccion = Input.get_axis("ui_left","ui_right")
	
	player.move_and_slide()
	
	if direccion != 0:
		state_machine.transition_to("Moving")
	elif !player.is_on_floor():
		state_machine.transition_to("Air")
	elif Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {Salto = true})

