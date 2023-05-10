extends CharacterBody2D
class_name Player

const jump := 250
const gravity := 9
const maxSaltos := 2

var speed := 120
var direccion := 0.0
var damage := 1
var numSaltos := maxSaltos
var canDash := true

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
@onready var frutaslabel := $PlayerGUI/HBoxContainer/frutaslabel
@onready var raycastDmg = $RaycastDmg
@onready var hpBar = $PlayerGUI/HPProgressBar
@onready var audioHurt = $AudioHurt

var vida := 10 :
	set(val):
		vida = val
		hpBar.value = vida

func _ready():
	Global.player = self
#
func _process(delta):
	for ray in raycastDmg.get_children():
		if ray.is_colliding():
			var collision = ray.get_collider()
			if collision.is_in_group("Enemigos"):
				if collision.has_method("takeDmg"):
					collision.takeDmg(damage)
	if is_on_floor():
		canDash = true
#
func actualizaInterfazFrutas():
	frutaslabel.text = str(Global.frutas)
#
func takeDmg(damage):
	audioHurt.play()
	vida -= damage
	anim.play("hurt")
	velocity.y = -jump*0.7
	if vida <= 0:
		get_tree().reload_current_scene()
