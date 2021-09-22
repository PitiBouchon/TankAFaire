extends Control
class_name UITankSelection


signal next_chassi
signal next_engine
signal next_track
signal next_turret
signal previous_chassi
signal previous_engine
signal previous_track
signal previous_turret

signal player_ready

export (int) var playerNumber

onready var statHP : Label = $Stats/HP
onready var statWeight : Label = $Stats/Weight
onready var statHorsePower : Label = $Stats/HorsePower
onready var statArmorType : Label = $Stats/ArmorType
onready var statMobility : Label = $Stats/Mobility

onready var chassi : UIElementSelection = $Chassi
onready var engine : UIElementSelection = $Engine
onready var tracks : UIElementSelection = $Tracks
onready var turret : UIElementSelection = $Turret

onready var ready  : ColorRect = $ReadyBG

var playerSelection : Vector2 = Vector2.ZERO
var selectionLimit : Vector2 = Vector2(5,2)
var playerReady : bool = false

func _ready():
	playerSelection = Vector2.ZERO
	playerReady = false
	updateDisplay()
	pass

func _input(event):
	if !playerReady && playerNumber == 1 :
		if event.is_action_pressed("player1_down"):
			playerSelection.x = clamp(playerSelection.x + 1, 0, selectionLimit.x - 1)
		elif event.is_action_pressed("player1_up"):
			playerSelection.x = clamp(playerSelection.x - 1, 0, selectionLimit.x - 1)
		if event.is_action_pressed("player1_right"):
			playerSelection.y = clamp(playerSelection.y + 1, 0, selectionLimit.y - 1)
		elif event.is_action_pressed("player1_left"):
			playerSelection.y = clamp(playerSelection.y - 1, 0, selectionLimit.y - 1)
		
		if event.is_action_pressed("player1_select") :
			signalEmiter()
		
	elif !playerReady && playerNumber == 2 :
		if event.is_action_pressed("player2_down"):
			playerSelection.x = clamp(playerSelection.x + 1, 0, selectionLimit.x - 1)
		elif event.is_action_pressed("player2_up"):
			playerSelection.x = clamp(playerSelection.x - 1, 0, selectionLimit.x - 1)
		if event.is_action_pressed("player2_right"):
			playerSelection.y = clamp(playerSelection.y + 1, 0, selectionLimit.y - 1)
		elif event.is_action_pressed("player2_left"):
			playerSelection.y = clamp(playerSelection.y - 1, 0, selectionLimit.y - 1)
		
		if event.is_action_pressed("player2_select") :
			signalEmiter()
	
	updateDisplay()
	return


func updateStats(healthPoint : float, weight : float, horsePower : float, armorType : float, maniability : int) -> void:
	statHP.text = "Points de vie : " + str(healthPoint)
	statWeight.text = "Poids : " + str(weight)
	statHorsePower.text = "Puissance : " + str(horsePower)
	statArmorType.text = "Blindage : " + str(armorType)
	statMobility.text = "Maniabilité : " + str(maniability) 
	pass

func updateDisplay() -> void:
	match playerSelection.x:
		0.0:
			if playerSelection.y == 0:
				chassi.selectPrevious()
			else:
				chassi.selectNext()
			engine.selectNone()
			tracks.selectNone()
			turret.selectNone()
			readyUnselect()
			
		1.0:
			chassi.selectNone()
			if playerSelection.y == 0:
				engine.selectPrevious()
			else:
				engine.selectNext()
			tracks.selectNone()
			turret.selectNone()
			readyUnselect()
			
		2.0:
			chassi.selectNone()
			engine.selectNone()
			if playerSelection.y == 0:
				tracks.selectPrevious()
			else:
				tracks.selectNext()
			turret.selectNone()
			readyUnselect()
			
		3.0:
			chassi.selectNone()
			engine.selectNone()
			tracks.selectNone()
			if playerSelection.y == 0:
				turret.selectPrevious()
			else:
				turret.selectNext()
			readyUnselect()
			
		4.0:
			chassi.selectNone()
			engine.selectNone()
			tracks.selectNone()
			turret.selectNone()
			readySelect()
	
	if playerReady:
		readyValidated()


func readyUnselect() -> void:
	ready.color = Color(0.5, 0.5, 0.5)

func readySelect() -> void:
	ready.color = Color(0.7, 0.7, 0)

func readyValidated() -> void:
	ready.color = Color(0, 0.7, 0)

func signalEmiter() -> void:
	match playerSelection.x:
		0.0:
			if playerSelection.y == 0:
				emit_signal("previous_chassi")
			else:
				emit_signal("next_chassi")
			
		1.0:
			if playerSelection.y == 0:
				emit_signal("previous_engine")
			else:
				emit_signal("next_engine")
			
		2.0:
			if playerSelection.y == 0:
				emit_signal("previous_track")
			else:
				emit_signal("next_track")
			
		3.0:
			if playerSelection.y == 0:
				emit_signal("previous_turret")
			else:
				emit_signal("next_turret")
			
		4.0:
			playerReady = true
			emit_signal("player_ready")
	pass
