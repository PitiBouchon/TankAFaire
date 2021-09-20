extends Spatial
class_name TanckSelection

signal tank_selected(tank1, tank2)

export (Array, Resource) var chassiList
export (Array, Resource) var engineList
export (Array, Resource) var trackList
export (Array, Resource) var turretList

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
	player1Indexes = [0,0,0,0]
	player2Indexes = [0,0,0,0]
	nbChassi = chassiList.size()
	nbEngine = engineList.size()
	nbTracks = trackList.size()
	nbTurret = turretList.size()


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
	pass # Replace with function body.


func _on_UIPlayer1_next_engine():
	pass # Replace with function body.


func _on_UIPlayer1_next_track():
	pass # Replace with function body.


func _on_UIPlayer1_next_turret():
	pass # Replace with function body.


func _on_UIPlayer1_player_ready():
	pass # Replace with function body.


func _on_UIPlayer1_previous_chassi():
	pass # Replace with function body.


func _on_UIPlayer1_previous_engine():
	pass # Replace with function body.


func _on_UIPlayer1_previous_track():
	pass # Replace with function body.


func _on_UIPlayer1_previous_turret():
	pass # Replace with function body.

# player 2 ----------------------------------

func _on_UIPlayer2_next_chassi():
	pass # Replace with function body.


func _on_UIPlayer2_next_engine():
	pass # Replace with function body.


func _on_UIPlayer2_next_track():
	pass # Replace with function body.


func _on_UIPlayer2_next_turret():
	pass # Replace with function body.


func _on_UIPlayer2_player_ready():
	pass # Replace with function body.


func _on_UIPlayer2_previous_chassi():
	pass # Replace with function body.


func _on_UIPlayer2_previous_engine():
	pass # Replace with function body.


func _on_UIPlayer2_previous_track():
	pass # Replace with function body.


func _on_UIPlayer2_previous_turret():
	pass # Replace with function body.
