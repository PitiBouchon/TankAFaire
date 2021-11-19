extends Spatial
class_name TanckSelection

signal tank_selected(tank1, tank2)
signal timeout


export (Array, Resource) var chassiList
export (Array, Resource) var engineList
export (Array, Resource) var trackList
export (Array, Resource) var turretList
export (Array, Resource) var gunList

export (Vector2) var healthLimits
export (Vector2) var damageLimits
export (Vector2) var speedLimits
export (Vector2) var armorLimits

onready var uiPlayer1 : UITankSelection = $UI/UIPlayer1
onready var uiPlayer2 : UITankSelection = $UI/UIPlayer2
onready var tankPlayer1 : DisplayTank = $Player1
onready var tankPlayer2 : DisplayTank = $Player2
onready var clock : AnimatedSprite = $UI/TimerControl/Clock

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
	
	clock.frame = 0


func updatePlayer1() -> void:
	tankOne.chassi = chassiList[player1Indexes[0]]
	tankOne.engine = engineList[player1Indexes[1]]
	tankOne.track = trackList[player1Indexes[2]]
	tankOne.turret = turretList[player1Indexes[3]]
	tankOne.gun = gunList[player1Indexes[4]]
	
	updateStats(tankOne, uiPlayer1)
	
	tankPlayer1.updateDisplay(tankOne)
	

func updatePlayer2() -> void:
	tankTwo.chassi = chassiList[player2Indexes[0]]
	tankTwo.engine = engineList[player2Indexes[1]]
	tankTwo.track = trackList[player2Indexes[2]]
	tankTwo.turret = turretList[player2Indexes[3]]
	tankTwo.gun = gunList[player2Indexes[4]]
	
	updateStats(tankTwo, uiPlayer2)
	
	tankPlayer2.updateDisplay(tankTwo)


func updateStats(tank : TankData, ui : UITankSelection) -> void:
	
	var health : float = tank.chassi.healthPoints + tank.turret.healthPoints
	var damage : float = 0.5 * tank.turret.secBulletData.damage + 0.5 * tank.gun.bulletData.damage 
	var weight : float = tank.chassi.weight + tank.turret.weight + tank.engine.weight + tank.track.weight + tank.gun.weight
	var speed : float = 100 + tank.engine.horsePower + tank.track.speedFactor - weight
	var armor : float = 0.5 * tank.chassi.armor + 0.5 * tank.turret.armor - tank.track.armorLoss 
	
	var healthRatio : float = (health - healthLimits.x) / (healthLimits.y - healthLimits.x)
	healthRatio = clamp(healthRatio, 0, 1)
	
	var damageRatio : float = (damage - damageLimits.x) / (damageLimits.y - damageLimits.x)
	damageRatio = clamp(damageRatio, 0, 1)
	
	var speedRatio : float = (speed - speedLimits.x) / (speedLimits.y - speedLimits.x)
	speedRatio = clamp(speedRatio, 0, 1)
	
	var armorRatio : float = (armor - armorLimits.x) / (armorLimits.y - armorLimits.x)
	armorRatio = clamp(armorRatio, 0, 1) 
	
	
	ui.updateStats(healthRatio, damageRatio, speedRatio, armorRatio)
	
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


func _on_Clock_animation_finished():
	emit_signal("timeout")
	pass # Replace with function body.
