extends Control

@onready var player_1: Control = $Player1
@onready var player_2: Control = $Player2
@onready var player_3: Control = $Player3
@onready var player_4: Control = $Player4
@onready var player_5: Control = $Player5
@onready var entries: Control = $entries

#get the leaderboard twin
func loadLeaderBoard():
	show()
	var config = ConfigFile.new()
	config.load(Saving.file_dir)
	for player in config.get_sections():
		var Name = str(config.get_value(player,"PlayerName")+" "+config.get_value(player,"lastName"))
		var Score = config.get_value(player,"score")
		for entry in entries.get_children():
			if entry.score < Score:
				print(entry.score," ",Score," ",Name)
				entry.score = Score
				entry.nameLabel.text = Name
				entry.scoreLabel.text = str(Score)
				break
