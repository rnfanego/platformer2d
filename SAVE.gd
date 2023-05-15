extends Node

const SAVEFILE = "user://SAVEFILE.save"

var game_data = {
#	"NUMERO" : 12,
#	"NivelDelJugador" : 0,
#	"ArmasDelJugador" : 12,
#	"HPMAX" : 100,
#	"NUEVO_VALOR" : 100
	"VidasJugador" : 10
}

func _ready():
	load_data()
	print(game_data)

func load_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ)
	if file == null:
		save_data()
	else:
		var data_saved = file.get_var()
		
		for data in game_data.keys():
			if !data_saved.keys().has(data):
				data_saved[data] = game_data[data]
		game_data = data_saved
				
	save_data()
	file = null 

func save_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.WRITE)
	file.store_var(game_data)
	file = null 



