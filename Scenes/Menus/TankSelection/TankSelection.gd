extends Spatial
class_name TanckSelection

signal tank_selected(tank1, tank2)

export (Array, Resource) var chassiList
export (Array, Resource) var engineList
export (Array, Resource) var trackList
export (Array, Resource) var turretList

onready var uiPlayer1 : UITankSelection = $UI/UIPlayer1
onready var uiPlayer2 : UITankSelection = $UI/UIPlayer2
onready var tankPlayer1 : DisplayTank = $Player1
onready var tankPlayer2 : DisplayTank = $Player2

var tankOne : TankData
var tankTwo : TankData

var player1Ready : bool
var player2Ready : bool

var player1Indexes : Array 
var player2Indexes : Array 

var nbChassi : int
var nbEngine : int
var nbTracks : int
var nbTurret : int


func _ready():
	tankOne = TankData.new()
	tankTwo = TankData.new()
	player1Ready = false
	player2Ready = false
	player1Indexes = [0,0,0,0] # chassi, engine, tracks, turret
	player2Indexes = [0,0,0,0]
	nbChassi = chassiList.size()
	nbEngine = engineList.size()
	nbTracks = trackList.size()
	nbTurret = turretList.size()
	
	updatePlayer1()
	updatePlayer2()


func updatePlayer1() -> void:
	tankOne.chassi = chassiList[player1Indexes[0]]
	tankOne.engine = engineList[player1Indexes[1]]
	tankOne.track = trackList[player1Indexes[2]]
	tankOne.turret = turretList[player1Indexes[3]]
	
	uiPlayer1.updateStats()
	
	tankPlayer1.updateDisplay(tankOne)
	

func updatePlayer2() -> void:
	tankTwo.chassi = chassiList[player2Indexes[0]]
	tankTwo.engine = engineList[player2Indexes[1]]
	tankTwo.track = trackList[player2Indexes[2]]
	tankTwo.turret = turretList[player2Indexes[3]]
	
	uiPlayer2.updateStats()
	
	tankPlayer2.updateDisplay(tankTwo)


# place holders --------------------------

func _on_DevPlaceHolder_pressed():
	devDefaultFill()
	emit_signal("tank_selected", tankOne, tankTwo)
	pass # Replace with function body.


func devDefaultFill():
	tankOne.chassi = chassiList[0]
	tankOne.engine = engineList[0]
	tankOne.track = trackList[0]
	tankOne.turret = turretList[0]
	
	tankTwo.chassi = chassiList[0]
	tankTwo.engine = engineList[0]
	tankTwo.track = trackList[0]
	tankTwo.turret = turretList[0]
	
	pass

# player 1 -------------------------------

func _on_UIPlayer1_next_chassi():
	player1Indexes[0] = (player1Indexes[0] + 1) % nbChassi
	updatePlayer1() 


func _on_UIPlayer1_next_engine():
	player1Indexes[1] = (player1Indexes[1] + 1) % nbEngine
	updatePlayer1()


func _on_UIPlayer1_next_track():
	player1Indexes[2] = (player1Indexes[2] + 1) % nbTracks
	updatePlayer1()


func _on_UIPlayer1_next_turret():
	player1Indexes[3] = (player1Indexes[3] + 1) % nbTurret
	updatePlayer1()


func _on_UIPlayer1_player_ready():
	player1Ready = true
	if player1Ready && player2Ready:
		emit_signal("tank_selected", tankOne, tankTwo)


func _on_UIPlayer1_previous_chassi():
	if player1Indexes[0] == 0:
		player1Indexes[0] = nbChassi - 1
	else:
		player1Indexes[0] -= 1
	updatePlayer1()


func _on_UIPlayer1_previous_engine():
	if player1Indexes[1] == 0:
		player1Indexes[1] = nbEngine - 1
	else:
		player1Indexes[1] -= 1
	updatePlayer1()


func _on_UIPlayer1_previous_track():
	if player1Indexes[2] == 0:
		player1Indexes[2] = nbTracks - 1
	else:
		player1Indexes[2] -= 1
	updatePlayer1()


func _on_UIPlayer1_previous_turret():
	if player1Indexes[3] == 0:
		player1Indexes[3] = nbTurret - 1
	else:
		player1Indexes[3] -= 1
	updatePlayer1()

# player 2 ----------------------------------

func _on_UIPlayer2_next_chassi():
	player2Indexes[0] = (player2Indexes[0] + 1) % nbChassi
	updatePlayer2()


func _on_UIPlayer2_next_engine():
	player2Indexes[1] = (player2Indexes[1] + 1) % nbEngine
	updatePlayer2()


func _on_UIPlayer2_next_track():
	player2Indexes[2] = (player2Indexes[2] + 1) % nbTracks
	updatePlayer2()


func _on_UIPlayer2_next_turret():
	player2Indexes[3] = (player2Indexes[3] + 1) % nbTurret
	updatePlayer2()


func _on_UIPlayer2_player_ready():
	player2Ready = true
	if player1Ready && player2Ready:
		emit_signal("tank_selected", tankOne, tankTwo)


func _on_UIPlayer2_previous_chassi():
	if player2Indexes[0] == 0:
		player2Indexes[0] = nbChassi - 1
	else:
		player2Indexes[0] -= 1
	updatePlayer2()


func _on_UIPlayer2_previous_engine():
	if player2Indexes[1] == 0:
		player2Indexes[1] = nbEngine - 1
	else:
		player2Indexes[1] -= 1
	updatePlayer2()


func _on_UIPlayer2_previous_track():
	if player2Indexes[2] == 0:
		player2Indexes[2] = nbTracks - 1
	else:
		player2Indexes[2] -= 1
	updatePlayer2()


func _on_UIPlayer2_previous_turret():
	if player2Indexes[3] == 0:
		player2Indexes[3] = nbTurret - 1
	else:
		player2Indexes[3] -= 1
	updatePlayer2()
