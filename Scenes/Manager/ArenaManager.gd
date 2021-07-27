extends Spatial
class_name ArenaManager

var TANK_SCENE := preload("res://Scenes/Tank/Tank.tscn")

func inistanciateTank(tankOne : TankData, tankTwo : TankData):
	var newTank : Tank = TANK_SCENE.instance()
	add_child(newTank)
	newTank.loadData(tankOne)
	newTank.translation = Vector3(10, 0, 0)
	
	newTank = TANK_SCENE.instance()
	add_child(newTank)
	newTank.loadData(tankTwo)
	newTank.translation = Vector3(-10, 0, 0)
	pass
