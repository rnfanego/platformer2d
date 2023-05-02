extends CharacterBody2D
class_name Player

var speed := 120
var direccion := 0.0
var damage := 1
const jump := 250
const gravity := 9

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
@onready var frutaslabel := $PlayerGUI/HBoxContainer/frutaslabel
@onready var raycastDmg = $RaycastDmg

func _ready():
	Global.player = self

func _physics_process(delta):
	direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * speed
	
	if direccion != 0:
		anim.play("walk")
	else:
		anim.play("idle")
	
	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
	
	if !is_on_floor():
		velocity.y += gravity
		
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y -= jump
	move_and_slide()

func _process(delta):
	for ray in raycastDmg.get_children():
		if ray.is_colliding():
			var collision = ray.get_collider()
			if collision.is_in_group("Enemigos"):
				if collision.has_method("takeDmg"):
					collision.takeDmg(damage)
	
func actualizaInterfazFrutas():
	frutaslabel.text = str(Global.frutas)
	
func takeDmg():
	get_tree().reload_current_scene()
