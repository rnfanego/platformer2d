extends PlayerState

var direccion 
func state_enter_state(msg := {}):
	direccion = Input.get_axis("ui_left","ui_right")
	player.velocity = Vector2.ZERO

func state_physics_process(delta):
	player.velocity.x = lerpf(player.velocity.x,-direccion * player.speed,.9)
	player.velocity.y = lerpf(player.velocity.y, -player.jump-10, .9)
	
	player.move_and_slide()
	
	if !player.is_on_floor() and player.velocity.y == -player.jump-10:
		state_machine.transition_to("Air")
	elif Input.is_action_just_pressed("dash") and player.canDash:
		state_machine.transition_to("Dash")
