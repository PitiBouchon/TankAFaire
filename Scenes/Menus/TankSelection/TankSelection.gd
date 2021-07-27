extends Control
class_name TanckSelection

signal tank_selected(tank1, tank2)

export (Array, Resource) var chassiList
export (Array, Resource) var engineList
export (Array, Resource) var trackList
export (Array, Resource) var turretList

var tankOne : TankData
var tankTwo : TankData

func _ready():
	tankOne = TankData.new()
	tankTwo = TankData.new()
	devDefaultFill()



func _on_DevPlaceHolder_pressed():
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
