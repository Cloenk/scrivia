extends Node2D

# The array of questions so we can add easily yayya
@export var questions: Array = []

# the actual question in text (java consumes me, I wanted to comment with //)
@onready var the_question: Label = $TheQuestion

# containers for the buttons :p
@onready var four_quest_button_container: GridContainer = $"Four quest Button container"
@onready var open_quest_button_container: CenterContainer = $"Open quest button container"
@onready var true_or_false_button_container: HBoxContainer = $"True or False button container"

# buttons for the 4 answer questions, mainly used for setting the text thingymajig
@onready var answer_one: Button = $"Four quest Button container/answer one"
@onready var answer_two: Button = $"Four quest Button container/answer two"
@onready var answer_three: Button = $"Four quest Button container/answer three"
@onready var answer_four: Button = $"Four quest Button container/answer four"

# the... qurrent question you jinkabob
var currentQuestionResource: Question

# line edit is used for user input, I used this in Typewriter :skull:
@onready var user_input: LineEdit = $"Open quest button container/User input"

func _ready() -> void:
	change_question()

# this is for picking a random new question (FOR READABILITY, I WILL COMMENT EVERYTHING CUZ I WANNAA
func change_question():
	currentQuestionResource = questions.pick_random()
	the_question.text = str(currentQuestionResource.question)
	# if esa four answerito possibleh
	if currentQuestionResource.isFourAnswers:
		# Devin, you can do the animations. for now I jujitsu set them to invisible or visible
		open_quest_button_container.visible = false
		true_or_false_button_container.visible = false
		four_quest_button_container.visible = true
		# set the text of the buttons to the answ
		answer_one.text = str(currentQuestionResource.firstAnswer)
		answer_two.text = str(currentQuestionResource.secondAnswer)
		answer_three.text = str(currentQuestionResource.thirdAnswer)
		answer_four.text = str(currentQuestionResource.fourthAnswer)
	# if it's an open question 
	elif currentQuestionResource.isOpenAnswer:
		# same as aboeve
		true_or_false_button_container.visible = false
		four_quest_button_container.visible = false
		open_quest_button_container.visible = true
	# if it's a true or false question
	elif currentQuestionResource.isTrueOrFalse:
		# burger
		four_quest_button_container.visible = false
		open_quest_button_container.visible = false
		true_or_false_button_container.visible = true

func check_correct_four_answer(clickedAnswer: int):
	if currentQuestionResource.isFourAnswers:
		if currentQuestionResource.correctAnswer == clickedAnswer:
			GlobalGame.game.add_points(currentQuestionResource.pointsWorth)
			print("correct four ans")
		else: 
			GlobalGame.game.incorrect_answer()
			print("incorrect four ans")
	change_question()

func check_correct_open_answer(userInp: String):
	if currentQuestionResource.isOpenAnswer:
		if currentQuestionResource.correctOpenAnswer.to_lower() == userInp.to_lower():
			GlobalGame.game.add_points(currentQuestionResource.pointsWorth)
			print("correct open ans")
		else:
			GlobalGame.game.incorrect_answer()
			print("incorrect open ans")
		diff_question_validator()

func check_correct_tof_answer(answ: int):
	if currentQuestionResource.isTrueOrFalse:
		if currentQuestionResource.correctTOFAnswer == answ:
			GlobalGame.game.add_points(currentQuestionResource.pointsWorth)
			print("correct tof ans")
		else:
			GlobalGame.game.incorrect_answer()
			print("incorrect tof ans")
		diff_question_validator()

func diff_question_validator():
	if GlobalGame.game.questionsHad <= GlobalGame.game.maxQuestions:
		GlobalGame.game.questionsHad += 1
		change_question()
	else: GlobalGame.game.end()

func _on_answer_one_pressed() -> void:
	check_correct_four_answer(1)

func _on_answer_two_pressed() -> void:
	check_correct_four_answer(2)

func _on_answer_three_pressed() -> void:
	check_correct_four_answer(3)

func _on_answer_four_pressed() -> void:
	check_correct_four_answer(4)

# this parses the user inp to the question checker
func _on_user_input_text_submitted(new_text: String) -> void:
	check_correct_open_answer(new_text)

#for these 2 down here, 0 is true and 1 is false
func _on_true_pressed() -> void:
	check_correct_tof_answer(0)

func _on_false_pressed() -> void:
	check_correct_tof_answer(1)
