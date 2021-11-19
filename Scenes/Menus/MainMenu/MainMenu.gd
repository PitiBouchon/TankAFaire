extends Control
class_name MainMenu

signal new_game

export (float) var selectionTimeout

onready var p1SelectedSprite : AnimatedSprite = $CanvasLayer/ControlP1/Selected
onready var p1UnselectedSprite : Sprite = $CanvasLayer/ControlP1/Unselected
onready var p1Timer : Timer = $P1Timer
onready var p2SelectedSprite : AnimatedSprite = $CanvasLayer/ControlP2/Selected
onready var p2UnselectedSprite : Sprite = $CanvasLayer/ControlP2/Unselected
onready var p2Timer : Timer = $P2Timer

var p1Selected : bool
var p2Selected : bool



func _ready():
	p1Selected = false
	p2Selected = false
	updateDisplay()


func _process(delta):
	if Input.is_action_just_pressed("player1_select"):
		p1Selected = true
		p1Timer.start(selectionTimeout)
		updateDisplay()
	
	if Input.is_action_just_pressed("player2_select"):
		p2Selected = true
		p2Timer.start(selectionTimeout)
		updateDisplay()
	pass

func updateDisplay() -> void:
	
	if p1Selected :
		p1SelectedSprite.show()
		p1UnselectedSprite.hide()
	else:
		p1SelectedSprite.hide()
		p1UnselectedSprite.show()
	
	if p2Selected :
		p2SelectedSprite.show()
		p2UnselectedSprite.hide()
	else:
		p2SelectedSprite.hide()
		p2UnselectedSprite.show()
	
	if p1Selected && p2Selected:
		emit_signal("new_game")
	
	return


func _on_P1Timer_timeout():
	p1Selected = false
	updateDisplay()
	pass # Replace with function body.


func _on_P2Timer_timeout():
	p2Selected = false
	updateDisplay()
	pass # Replace with function body.
