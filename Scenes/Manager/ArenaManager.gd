extends Spatial
class_name ArenaManager

var TANK_SCENE := preload("res://Scenes/Tank/Tank.tscn")

var MAP := preload("res://Scenes/Arenas/Arena2.tscn")

var active_map
var tank1
var tank2 


func inistanciateTank(tankOne : TankData, tankTwo : TankData) -> void:
	tank1 = TANK_SCENE.instance() 
	add_child(tank1)
	tank1.loadData(tankOne, 1)
	
	tank2 = TANK_SCENE.instance() 
	add_child(tank2)
	tank2.loadData(tankTwo, 2)
	
	active_map=MAP.instance()
	add_child(active_map)
	
	
	
	tank1.translation = active_map.get_node("SpawnPoints/SpawnPoint1").translation
	tank2.translation = active_map.get_node("SpawnPoints/SpawnPoint2").translation
	return


func getTankPositionByID(id : int) -> Vector3:
	if id == 1:
		return tank1.translation
	return tank2.translation
