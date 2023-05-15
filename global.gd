extends Node

var frutas := 0 :
	set(val):
		frutas = val
		if player != null:
			player.actualizaInterfazFrutas()
			$frutasSonido.play()
	get:
		return frutas

var player

var vidas : int

func _ready():
	await (Save.ready)
	vidas = Save.game_data.VidasJugador
