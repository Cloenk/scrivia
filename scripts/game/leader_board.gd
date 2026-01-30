extends Control

@onready var player_1: Control = $entries/Player1
@onready var player_2: Control = $entries/Player2
@onready var player_3: Control = $entries/Player3
@onready var player_4: Control = $entries/Player4
@onready var player_5: Control = $entries/Player5
@onready var entries: Control = $entries

# Get the leaderboard twin
func loadLeaderBoard():
	show()
	var config = ConfigFile.new()
	config.load(Saving.file_dir)
	
	# Load all scores into an array
	var scores_array = []
	for player in config.get_sections():
		var player_name = str(config.get_value(player, "PlayerName") + " " + config.get_value(player, "lastName"))
		var player_score = config.get_value(player, "score")
		scores_array.append({"name": player_name, "score": player_score})
	
	# Sort the array by score (descending)
	scores_array.sort_custom(func(a, b): return a.score > b.score)
	
	# Keep only top 5
	if scores_array.size() > 5:
		scores_array.resize(5)
	
	# Update the UI entries
	var entry_nodes = entries.get_children()
	for i in range(entry_nodes.size()):
		if i < scores_array.size():
			entry_nodes[i].score = scores_array[i].score
			entry_nodes[i].nameLabel.text = scores_array[i].name
			entry_nodes[i].scoreLabel.text = str(scores_array[i].score)
		else:
			# Clear entries that don't have data
			entry_nodes[i].score = 0
			entry_nodes[i].nameLabel.text = "---"
			entry_nodes[i].scoreLabel.text = "0"
