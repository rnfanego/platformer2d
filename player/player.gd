extends CharacterBody2D
class_name Player

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
@onready var frutaslabel := $PlayerGUI/HBoxContainer/frutaslabel
@onready var raycastDmg = $RaycastDmg
@onready var hpBar = $PlayerGUI/HPProgressBar

var speed := 120
var direccion := 0.0
var damage := 1
const jump := 250
const gravity := 9

enum estados {NORMAL,HERIDO}
var estadoActual = estados.NORMAL

var vida := 10 :
	set(val):
		vida = val
		hpBar.value = vida

func _ready():
	Global.player = self

func _physics_process(delta):
	if estadoActual == estados.NORMAL:
		processNormal()

func processNormal():
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
	
func takeDmg(damage):
	if estadoActual != estados.HERIDO:
		vida -= damage
		anim.play("hurt")
		estadoActual = estados.HERIDO
		print(vida)
		if vida <= 0:
			get_tree().reload_current_scene()


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"hurt":
			estadoActual = estados.NORMAL
