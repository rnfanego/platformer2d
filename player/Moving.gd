extends PlayerState

func state_physics_process(delta):
	var direccion = Input.get_axis("ui_left","ui_right")
	
	player.sprite.flip_h = direccion < 0 if direccion != 0 else player.sprite.flip_h
	player.velocity.x = direccion * player.speed
	player.velocity.y += player.gravity
	player.move_and_slide()
	
	if direccion == 0:
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {Salto = true})
	elif Input.is_action_just_pressed("dash") and player.canDash:
		state_machine.transition_to("Dash")
	elif !player.is_on_floor():
		state_machine.transition_to("Air")

func state_enter_state(msg := {}):
	anim_player.play("walk")
