extends PlayerState

@onready var audioJump = $"../../AudioJump"

func state_enter_state(msg := {}):
	if msg.has("Salto"):
		audioJump.play()
		anim_player.play("jump")
		player.numSaltos -= 1
		player.velocity.y = -player.jump
	else:
		anim_player.play("fall")

func state_physics_process(delta):
	var direccion = Input.get_axis("ui_left","ui_right")
	
	player.sprite.flip_h = direccion < 0 if direccion != 0 else player.sprite.flip_h
	player.velocity.x = direccion * player.speed
	player.velocity.y += player.gravity
	
	player.move_and_slide()
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
		player.numSaltos = player.maxSaltos
	elif Input.is_action_just_pressed("ui_accept") and player.numSaltos > 0:
		state_machine.transition_to("Air", {Salto = true})
