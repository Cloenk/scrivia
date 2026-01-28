extends Resource
class_name Question

@export_category("basics")
@export var question: String
@export var isFourAnswers: bool
@export var isOpenAnswer: bool
@export var isTrueOrFalse: bool
@export var pointsWorth: float

@export_category("fourAnswerSettings")
@export var firstAnswer: String
@export var secondAnswer: String
@export var thirdAnswer: String
@export var fourthAnswer: String
@export var correctAnswer: int

@export_category("openQuestionSettings")
@export var correctOpenAnswer: String

@export_category("trueOrFalseSettings")
@export var correctTOFAnswer: int
var trueAnswer := 0
var falseAnswer := 1
