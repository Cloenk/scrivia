extends Node2D
class_name globertGame

@onready var leader_board: Control = $CanvasLayer/LeaderBoard
@onready var question_display: Node2D = $QuestionDisplay

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
	question_display.hide()
	leader_board.loadLeaderBoard()
