extends Control
class_name TanckSelection

signal tank_selected

func _on_DevPlaceHolder_pressed():
	emit_signal("tank_selected")
	pass # Replace with function body.
