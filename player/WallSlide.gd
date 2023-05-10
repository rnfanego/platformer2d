extends PlayerState


func state_enter_state(msg := {}):
	anim_player.play("wallSlide")
	player.velocity.y = 0

func state_physics_process(delta):
	var direccion = Input.get_axis("ui_left","ui_right")
	player.velocity.x = direccion * player.speed
	player.velocity.y += player.gravity*.5
	player.move_and_slide()
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	elif !player.is_on_wall():
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("WallJump")
