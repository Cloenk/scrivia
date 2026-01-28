extends Label
class_name LabelButton

var canBePressed = false

signal pressed

#WARNING WARNING EXTREME JANK TRIGGER WARNING

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	mouse_entered.connect(enter)
	mouse_exited.connect(exit)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and canBePressed:
		pressed.emit()

func enter():
	canBePressed = true
func exit():
	canBePressed = false
