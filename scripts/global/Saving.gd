extends Node

var file_dir = "res://player_data.cfg"

func savePlayer(Name: String, lastName: String, Score: float, email: String, huidigSchool: String, leerjaar: String):
	var config = ConfigFile.new()
	config.load(file_dir)
	config.set_value(Name,"PlayerName",Name)
	config.set_value(Name,"lastName",lastName)
	config.set_value(Name,"score",Score)
	config.set_value(Name,"email",email)
	config.set_value(Name,"huidigSchool",huidigSchool)
	config.set_value(Name,"leerjaar",leerjaar)
	config.save(file_dir)

func loadPlayers():
	var config = ConfigFile.new()
	config.load(file_dir)
	for player in config.get_sections():
		print(config.get_value(player,"PlayerName"))
