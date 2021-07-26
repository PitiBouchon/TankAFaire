extends Control
class_name MainMenu

signal new_game


func on_new_game_pressed():
	emit_signal("new_game")
	pass # Replace with function body.
