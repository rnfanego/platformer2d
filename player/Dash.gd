extends PlayerState

@onready var sprite_2d = $"../../Sprite2D"
@onready var dash_timer = $DashTimer
var dashSpeed = 300

func state_enter_state(msg := {}):
	dash_timer.start()
	player.canDash = false
	player.velocity.y = Input.get_axis("ui_up","ui_down") * dashSpeed
	player.velocity.x = Input.get_axis("ui_left","ui_right") * dashSpeed
	
func state_physics_process(delta):
	player.move_and_slide()

func _on_dash_timer_timeout():
	state_machine.transition_to("Idle")
