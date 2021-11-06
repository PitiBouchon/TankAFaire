extends Spatial
class_name TanckSelection

signal tank_selected(tank1, tank2)

export (Array, Resource) var chassiList
export (Array, Resource) var engineList
export (Array, Resource) var trackList
export (Array, Resource) var turretList
export (Array, Resource) var gunList

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
var nbGun : int


func _ready():
	tankOne = TankData.new()
	tankTwo = TankData.new()
	player1Ready = false
	player2Ready = false
	player1Indexes = [0,0,0,0,0] # chassi, engine, tracks, turret, gun
	player2Indexes = [0,0,0,0,0]
	nbChassi = chassiList.size()
	nbEngine = engineList.size()
	nbTracks = trackList.size()
	nbTurret = turretList.size()
	nbGun = gunList.size()
	
	updatePlayer1()
	updatePlayer2()


func updatePlayer1() -> void:
	tankOne.chassi = chassiList[player1Indexes[0]]
	tankOne.engine = engineList[player1Indexes[1]]
	tankOne.track = trackList[player1Indexes[2]]
	tankOne.turret = turretList[player1Indexes[3]]
	tankOne.gun = gunList[player1Indexes[4]]
	
	var hp : float = tankOne.chassi.healthPoints + tankOne.turret.healthPoints
	var weight : float = tankOne.chassi.weight + tankOne.engine.weight + tankOne.track.weight + tankOne.turret.weight + tankOne.gun.weight
	var power : float = tankOne.engine.horsePower
	var armor : float = 0.5 * tankOne.chassi.armorType + 0.5 * tankOne.turret.armorType
	var maniability : int = tankOne.track.maniabilityLevel
	
	uiPlayer1.updateStats(hp, weight, power, armor, maniability)
	
	tankPlayer1.updateDisplay(tankOne)
	

func updatePlayer2() -> void:
	tankTwo.chassi = chassiList[player2Indexes[0]]
	tankTwo.engine = engineList[player2Indexes[1]]
	tankTwo.track = trackList[player2Indexes[2]]
	tankTwo.turret = turretList[player2Indexes[3]]
	tankTwo.gun = gunList[player2Indexes[4]]
	
	var hp : float = tankTwo.chassi.healthPoints + tankTwo.turret.healthPoints
	var weight : float = tankTwo.chassi.weight + tankTwo.engine.weight + tankTwo.track.weight + tankTwo.turret.weight + tankTwo.gun.weight
	var power : float = tankTwo.engine.horsePower
	var armor : float = 0.5 * tankTwo.chassi.armorType + 0.5 * tankTwo.turret.armorType
	var maniability : int = tankTwo.track.maniabilityLevel
	
	uiPlayer2.updateStats(hp, weight, power, armor, maniability)
	
	tankPlayer2.updateDisplay(tankTwo)


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

func _on_UIPlayer1_next_gun():
	player1Indexes[4] = (player1Indexes[4] + 1) % nbTurret
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

func _on_UIPlayer1_previous_gun():
	if player1Indexes[4] == 0:
		player1Indexes[4] = nbGun - 1
	else:
		player1Indexes[4] -= 1
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

func _on_UIPlayer2_next_gun():
	player2Indexes[4] = (player2Indexes[4] + 1) % nbTurret
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


func _on_UIPlayer2_previous_gun():
	if player2Indexes[4] == 0:
		player2Indexes[4] = nbGun - 1
	else:
		player2Indexes[4] -= 1
	updatePlayer2()
