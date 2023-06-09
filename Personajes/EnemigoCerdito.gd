extends Personajes

var direccion = -1
@onready var sprite = $Sprite2D
@onready var raysuelo = $RayCasts/RayCastSuelo
@onready var raymuro = $RayCasts/RayCastMuro
@onready var rayPlayerDetector = $RayCasts/RayCastPlayerDetector
@onready var rays = $RayCasts
@onready var rayTimer = $RayCasts/RayTimer
@onready var playerDetectorTimer = $RayCasts/PlayerDetectorTimer
@onready var anim = $AnimationPlayer
@onready var colShape = $CollisionShape2D
@onready var dmgColShape = $dmgPlayer/CollisionShape2D

var canChangeDirection = true
var player : Player
enum estados {ANGRY, PATROL, DEAD}
var estadoActual = estados.PATROL
var angry = false

func _ready():
	speed = 80
	anim.play("walk")

func _physics_process(delta):
	velocity.x = direccion * speed
	
	if !is_on_floor():
		velocity.y += 9
	
	move_and_slide()

func _process(delta):
	if rayPlayerDetector.is_colliding() and estadoActual != estados.DEAD:
		var colision = rayPlayerDetector.get_collider()
		if colision.is_in_group("Player"):
			player = colision
			estadoActual = estados.ANGRY
			playerDetectorTimer.start(5)
	
	if estadoActual == estados.ANGRY:
		anim.play("runAngry")
		var directionPlayer = global_position.direction_to(player.global_position)
		if directionPlayer.x <= 0.1:
			direccion = -1
			raymuro.scale.x = 1
			rayPlayerDetector.scale.x = 1
		elif directionPlayer.x > 0:
			direccion = 1
			raymuro.scale.x = -1
			rayPlayerDetector.scale.x = -1
		sprite.flip_h = true if direccion == 1 else false
	
	if estadoActual == estados.PATROL:
		if canChangeDirection and (raymuro.is_colliding() or !raysuelo.is_colliding()):
			canChangeDirection = false
			rayTimer.start()
			direccion *= -1
			raymuro.scale.x *= -1
			rayPlayerDetector.scale.x *= -1
			sprite.flip_h = true if direccion == 1 else false		
	

func takeDmg(damage):
	vida -= damage
	if vida <= 0:
		dmgColShape.set_deferred("disabled", true)
		estadoActual = estados.DEAD
		anim.play("hurt")
		colShape.set_deferred("disabled",true)
		await anim.animation_finished
		queue_free()

func _on_ray_timer_timeout():
	canChangeDirection = true

func _on_player_detector_timer_timeout():
	estadoActual = estados.PATROL
	anim.play("walk")

func _on_dmg_player_body_entered(body):
	if body is Player:
		body.takeDmg(damage)
