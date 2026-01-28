extends Node2D
class_name globertGame

# keeps track of how many points the player has as a floating woating bubble
var currentPoints := 0.0

# keeps track of how many questions the player has answered
var questionsHad := 0

# keeps track of how many questions the player can answer
@export var maxQuestions := 0

func _ready() -> void:
	GlobalGame.game = self

func add_points(amount):
	currentPoints += amount

func incorrect_answer():
	pass # TODO devin what shalleth we do here (sum like animation type shite)

func end():
	pass # TODO I already added the end trigger, now only an animation and the scoreboard and those thingymajigs
