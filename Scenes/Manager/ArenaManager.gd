extends Spatial
class_name ArenaManager

var TANK_SCENE := preload("res://Scenes/Tank/Tank.tscn")
var tank1
var tank2 


func inistanciateTank(tankOne : TankData, tankTwo : TankData) -> void:
	tank1 = TANK_SCENE.instance() 
	add_child(tank1)
	tank1.loadData(tankOne, 1)
	tank1.translation = Vector3(10, 0, 0)
	
	tank2 = TANK_SCENE.instance() 
	add_child(tank2)
	tank2.loadData(tankTwo, 2)
	tank2.translation = Vector3(-10, 0, 0)
	return


func getTankPositionByID(id : int) -> Vector3:
	if id == 1:
		return tank1.translation
	return tank2.translation
