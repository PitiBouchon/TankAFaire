extends Node
class_name GameManager



var MAIN_MENU := preload("res://Scenes/Menus/MainMenu/MainMenu.tscn")

enum GAME_STATE {MAIN_MENU, NEW_GAME}
var gameState

# Called when the node enters the scene tree for the first time.
func _ready():
	on_load_main_menu()
	pass # Replace with function body.


func on_load_main_menu():
	var mainMenu : MainMenu = MAIN_MENU.instance()
	add_child(mainMenu)
	mainMenu.connect("new_game", self, "on_new_game")
	gameState = GAME_STATE.MAIN_MENU
	
	pass


func on_new_game():
	if gameState == GAME_STATE.MAIN_MENU :
		$MainMenu.queue_free()
		pass
	print("new game")
	gameState = GAME_STATE.NEW_GAME
	pass
