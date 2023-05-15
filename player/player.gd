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
@onready var gui_animation_player = $PlayerGUI/GUIAnimationPlayer

var vida := 10 :
	set(val):
		vida = val
		hpBar.value = vida

func _ready():
	#await (Global._ready())
	Global.player = self
	print(Global.vidas)
	gui_animation_player.play("TransitionAnim")
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
		die()

func die():
	Global.vidas -= 1
	Save.game_data.VidasJugador = Global.vidas
	Save.save_data()
	transitionToScene(get_tree().current_scene.scene_file_path)
	
func transitionToScene(scene):
	gui_animation_player.play_backwards("TransitionAnim")
	get_tree().paused = true
	await (gui_animation_player.animation_finished)
	get_tree().paused = false
	get_tree().change_scene_to_file(scene)
	
	
