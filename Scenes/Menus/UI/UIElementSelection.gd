extends Control
class_name UIElementSelection

export (String) var selectionName

onready var previousOn : TextureRect = $Previous_ON
onready var previousOff : TextureRect = $Previous_OFF
onready var nextOn : TextureRect = $Next_ON
onready var nextOff : TextureRect = $Next_OFF
onready var label : Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = selectionName
	selectNone()

func selectPrevious() -> void:
	previousOn.show()
	previousOff.hide()
	nextOn.hide()
	nextOff.show()

func selectNext() -> void:
	previousOn.hide()
	previousOff.show()
	nextOn.show()
	nextOff.hide()

func selectNone() -> void:
	previousOn.hide()
	previousOff.show()
	nextOn.hide()
	nextOff.show()
