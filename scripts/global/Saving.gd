extends Node

var file_dir = "res://player_data.cfg"

func _ready() -> void: #for adding them manualy
	pass
	#savePlayer("opa jan6","dark",100,"ikke@burger.nl","brgferschool","4")

#save it twin
func savePlayer(Name: String, lastName: String, Score: float, email: String, huidigSchool: String, leerjaar: String):
	var config = ConfigFile.new()
	config.load(file_dir)
	config.set_value(Name+" "+lastName,"PlayerName",Name)
	config.set_value(Name+" "+lastName,"lastName",lastName)
	config.set_value(Name+" "+lastName,"score",Score)
	config.set_value(Name+" "+lastName,"email",email)
	config.set_value(Name+" "+lastName,"huidigSchool",huidigSchool)
	config.set_value(Name+" "+lastName,"leerjaar",leerjaar)
	config.save(file_dir)
