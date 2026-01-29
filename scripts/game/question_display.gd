extends Node2D

const QUESTION_BOX_LEFT = preload("uid://oedqwgdi2q01")
const QUESTION_BOX_MIDDLE = preload("uid://bxp28yipyaql2")
const QUESTION_BOX_RIGHT = preload("uid://dsvol1l2qo5lt")

# The array of questions so we can add easily yayya
@export var questions: Array[Question] = []

#the fog is coming
@onready var box_container: Node2D = $BoxContainer
@onready var false_button: LabelButton = $FalseButton
@onready var true_button: LabelButton = $TrueButton

# the actual question in text (java consumes me, I wanted to comment with //)
@onready var the_question: Label = $TheQuestion

# containers for the buttons :p
@onready var four_quest_button_container: GridContainer = $"Four quest Button container"
@onready var open_quest_button_container: CenterContainer = $"Open quest button container"

# buttons for the 4 answer questions, mainly used for setting the text thingymajig
@onready var answer_1: LabelButton = $"Four quest Button container/answer 1"
@onready var answer_2: LabelButton = $"Four quest Button container/answer 2"
@onready var answer_3: LabelButton = $"Four quest Button container/answer 3"
@onready var answer_4: LabelButton = $"Four quest Button container/answer 4"

# the... qurrent question you jinkabob
var currentQuestionResource: Question

# line edit is used for user input, I used this in Typewriter :skull:
@onready var user_input: LineEdit = $"Open quest button container/User input"

func _ready() -> void:
	change_question()

func change_question():
	clearQuestionBoxes()
	currentQuestionResource = questions.pick_random()
	the_question.text = str(currentQuestionResource.question)
	
	# if esa four answerito possibleh
	if currentQuestionResource.isFourAnswers:
		open_quest_button_container.visible = false
		false_button.visible = false
		true_button.visible = false
		four_quest_button_container.visible = true
		
		# set the text of the buttons to the answ
		answer_1.text = str(currentQuestionResource.firstAnswer)
		answer_2.text = str(currentQuestionResource.secondAnswer)
		answer_3.text = str(currentQuestionResource.thirdAnswer)
		answer_4.text = str(currentQuestionResource.fourthAnswer)
		
		# Create boxes grouped by side
		await createQuestionBoxesBySide([answer_1, answer_2, answer_3, answer_4])
		
	# if it's an open question 
	elif currentQuestionResource.isOpenAnswer:
		false_button.visible = false
		true_button.visible = false
		four_quest_button_container.visible = false
		open_quest_button_container.visible = true
		
	# if it's a true or false question
	elif currentQuestionResource.isTrueOrFalse:
		four_quest_button_container.visible = false
		open_quest_button_container.visible = false
		false_button.visible = true
		true_button.visible = true
		
		# Create boxes grouped by side
		await createQuestionBoxesBySide([false_button, true_button])
	
	# create question box for the question
	createQuestionBox(the_question)

# New function to create boxes grouped by screen side
func createQuestionBoxesBySide(labels: Array):
	# Wait for labels to update their sizes and positions
	await get_tree().process_frame
	await get_tree().process_frame
	
	# Force size recalculation
	for label in labels:
		if label is Control:
			label.reset_size()
	
	# Wait one more frame to ensure positions are updated
	await get_tree().process_frame
	
	# Get screen center
	var screen_center_x = get_viewport_rect().size.x / 2.0
	
	# Group labels by side and find max width per side
	var left_labels = []
	var right_labels = []
	var max_width_left = 0.0
	var max_width_right = 0.0
	
	for label in labels:
		if label.global_position.x < screen_center_x:
			left_labels.append(label)
			max_width_left = max(max_width_left, label.size.x)
		else:
			right_labels.append(label)
			max_width_right = max(max_width_right, label.size.x)
	
	# Create boxes for left side labels
	for label in left_labels:
		createQuestionBoxWithSize(label, max_width_left)
	
	# Create boxes for right side labels
	for label in right_labels:
		createQuestionBoxWithSize(label, max_width_right)

# Modified function that accepts a specific width
func createQuestionBoxWithSize(label: Node, width: float):
	var size = width / 100
	var pos = label.global_position + Vector2(-30, 60)
	
	# Create left cap
	var newSprite = Sprite2D.new()
	newSprite.texture = QUESTION_BOX_LEFT
	newSprite.scale = Vector2(10, 10)
	newSprite.global_position = pos
	box_container.add_child(newSprite)
	
	pos.x += 25
	
	# Create middle sections
	while size >= 0:
		size -= 0.5
		var newerSprite = Sprite2D.new()
		newerSprite.texture = QUESTION_BOX_MIDDLE
		newerSprite.scale = Vector2(10, 10)
		box_container.add_child(newerSprite)
		pos.x += 50
		newerSprite.global_position = pos
	
	# Create right cap
	var newestSprite = Sprite2D.new()
	newestSprite.texture = QUESTION_BOX_RIGHT
	newestSprite.scale = Vector2(10, 10)
	newestSprite.global_position = pos + Vector2(50, 0)
	box_container.add_child(newestSprite)

# Keep the original function for the question label
func createQuestionBox(label: Node):
	await get_tree().process_frame
	await get_tree().process_frame
	
	if label is Control:
		label.reset_size()
	
	createQuestionBoxWithSize(label, label.size.x)

func clearQuestionBoxes(): #burger deletion
	for Box: Sprite2D in box_container.get_children():
		Box.queue_free()

func check_correct_four_answer(clickedAnswer: int):
	if currentQuestionResource.isFourAnswers:
		if currentQuestionResource.correctAnswer == clickedAnswer:
			GlobalGame.game.add_points(currentQuestionResource.pointsWorth)
			print("correct four ans") #geen sysout in je pr
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
	user_input.clear()

#for these 2 down here, 0 is true and 1 is false-tim JUST USE A BOOLEAN BRUH???-devin
func _on_true_pressed() -> void:
	check_correct_tof_answer(0)

func _on_false_pressed() -> void:
	check_correct_tof_answer(1)
