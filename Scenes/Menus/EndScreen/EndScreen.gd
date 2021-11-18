extends Control
class_name EndScreen

signal load_main_screen

export (float) var timeOut

onready var p1Victory : TextureRect = $P1_Victory
onready var p1Defeat : TextureRect = $P1_Defeat
onready var p2Victory : TextureRect = $P2_Victory
onready var p2Deafeat : TextureRect = $P2_Defeat

func init(victorId) -> void:
	
	match victorId :
		0 :
			p1Defeat.show()
			p1Victory.hide()
			p2Deafeat.show()
			p2Victory.hide()
		
		1 :
			p1Defeat.hide()
			p1Victory.show()
			p2Deafeat.show()
			p2Victory.hide()
		2 :
			p1Defeat.show()
			p1Victory.hide()
			p2Deafeat.hide()
			p2Victory.show()
	
	yield(get_tree().create_timer(timeOut), "timeout")
	
	emit_signal("load_main_screen")
	
	pass


