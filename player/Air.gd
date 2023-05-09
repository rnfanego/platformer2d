extends PlayerState

@onready var audioJump = $"../../AudioJump"
@onready var coyoteTimer = $CoyoteTimer
@onready var jump_buffer_timer = $JumpBufferTimer

var hasJumped = false

func state_enter_state(msg := {}):
	if msg.has("Salto"):
		hasJumped = true
		audioJump.play()
		anim_player.play("jump")
		player.numSaltos -= 1
		player.velocity.y = -player.jump
	else:
		hasJumped = false
		coyoteTimer.start()
		anim_player.play("fall")

func state_physics_process(delta):
	var direccion = Input.get_axis("ui_left","ui_right")
	
	player.sprite.flip_h = direccion < 0 if direccion != 0 else player.sprite.flip_h
	player.velocity.x = direccion * player.speed
	player.velocity.y += player.gravity
	
	player.move_and_slide()
	
	if player.is_on_floor():
		player.numSaltos = player.maxSaltos
		hasJumped = false
		if jump_buffer_timer.is_stopped():
			state_machine.transition_to("Idle")
		else:
			jump_buffer_timer.stop()
			state_machine.transition_to("Air", {Salto = true})
	elif (hasJumped or !coyoteTimer.is_stopped()) and Input.is_action_just_pressed("ui_accept") and player.numSaltos > 0:
		state_machine.transition_to("Air", {Salto = true})
	elif Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer.start()
