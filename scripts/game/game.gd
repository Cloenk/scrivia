extends Node2D
class_name globertGame

@onready var leader_board: Control = $CanvasLayer/LeaderBoard
@onready var question_display: Node2D = $QuestionDisplay

var Name: String
var lastName: String
var email: String
var huidigSchool: String
var leerjaar: String

@onready var form: Node2D = $Form

@onready var question_display: Node2D = $QuestionDisplay
@onready var wil_je_: Label = $"Form/wil je?"
@onready var wil_je_een_meeloopdag_: HBoxContainer = $"Form/Wil je een meeloopdag?"

# keeps track of how many points the player has as a floating woating bubble
var currentPoints := 0.0

# keeps track of how many questions the player has answered
var questionsHad := 0

# keeps track of how many questions the player can answer
@export var maxQuestions := 0

func _ready() -> void:
	GlobalGame.game = self
	unshow_register_form()

func add_points(amount):
	currentPoints += amount

func incorrect_answer():
	pass # TODO devin what shalleth we do here (sum like animation type shite)

func actually_save():
	print("n: ", Name, " ln: ", lastName, " pts: ", currentPoints, " em: ", email, " hs: ", huidigSchool, " lj: ", leerjaar)
	Saving.savePlayer(Name, lastName, currentPoints, email, huidigSchool, leerjaar) 
	Name = ""
	lastName = ""
	currentPoints = 0.0
	email = ""
	huidigSchool = ""
	leerjaar = ""
	# TODO to leadeerboatdr

func end():
	question_display.hide()
	leader_board.loadLeaderBoard()
	show_register_form()
	# TODO I already added the end trigger, now only an animation and the scoreboard and those thingymajigs

func show_register_form():
	question_display.visible = false
	form.visible = true

func unshow_register_form():
	form.visible = false

func _on_submit_pressed() -> void:
	actually_save()

func _on_name_text_changed(new_text: String) -> void:
	Name = new_text

func _on_last_name_text_changed(new_text: String) -> void:
	lastName = new_text

func _on_email_text_changed(new_text: String) -> void:
	email = new_text

func _on_huidig_school_text_changed(new_text: String) -> void:
	huidigSchool = new_text

func _on_leerjaar_text_changed(new_text: String) -> void:
	leerjaar = new_text

func _on_nee_pressed() -> void:
	pass
	# TODO Show learderbrood

func _on_ja_pressed() -> void:
	show_register_form()
