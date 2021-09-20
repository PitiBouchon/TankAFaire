extends Control
class_name UIElementSelection

export (String) var selectionName

onready var previousTexture : TextureRect = $Previous
onready var nextTexture : TextureRect = $Next
onready var label : Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = selectionName
	previousTexture.set_self_modulate(Color(1,1,1,0.5))
	nextTexture.set_self_modulate(Color(1,1,1,0.5))

func selectPrevious() -> void:
	previousTexture.set_self_modulate(Color(1,1,1,1))
	nextTexture.set_self_modulate(Color(1,1,1,0.5))

func selectNext() -> void:
	previousTexture.set_self_modulate(Color(1,1,1,0.5))
	nextTexture.set_self_modulate(Color(1,1,1,1))

func selectNone() -> void:
	previousTexture.set_self_modulate(Color(1,1,1,0.5))
	nextTexture.set_self_modulate(Color(1,1,1,0.5))
