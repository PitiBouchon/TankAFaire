extends Node
class_name GameManager



var MAIN_MENU := preload("res://Scenes/Menus/MainMenu/MainMenu.tscn")
var TANK_SELECTION := preload("res://Scenes/Menus/TankSelection/TankSelection.tscn")
var ARENA_MANAGER := preload("res://Scenes/Manager/ArenaManager.tscn")

enum GAME_STATE {MAIN_MENU, TANK_SELECTION, MAIN_GAME}
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
		var tankSelection : TanckSelection = TANK_SELECTION.instance()
		add_child(tankSelection)
		tankSelection.connect("tank_selected", self, "on_tank_selected")
		gameState = GAME_STATE.TANK_SELECTION
	
	pass

func on_tank_selected(tankOne : TankData, tankTwo : TankData):
	if gameState == GAME_STATE.TANK_SELECTION:
		$TankSelection.queue_free()
		var arenaManager : ArenaManager = ARENA_MANAGER.instance()
		add_child(arenaManager)
		arenaManager.inistanciateTank(tankOne, tankTwo)
		
		gameState = GAME_STATE.MAIN_GAME
	pass
