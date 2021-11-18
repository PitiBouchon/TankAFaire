extends Spatial
class_name ArenaManager

var TANK_SCENE := preload("res://Scenes/Tank/Tank.tscn")

var MAP := preload("res://Scenes/Arenas/Arena2.tscn")

var active_map
var tank1
var tank2 


onready var healthP1 : TextureProgress = $UI/Health_P1
onready var healthP2 : TextureProgress = $UI/Health_P2
onready var dashP1 : AnimatedSprite = $UI/DashControlP1/Dash_P1
onready var dashP2 : AnimatedSprite = $UI/DashControlP2/Dash_P2


func inistanciateTank(tankOne : TankData, tankTwo : TankData) -> void:
	tank1 = TANK_SCENE.instance() 
	add_child(tank1)
	tank1.loadData(tankOne, 1)
	
	tank2 = TANK_SCENE.instance() 
	add_child(tank2)
	tank2.loadData(tankTwo, 2)
	
	active_map=MAP.instance()
	add_child(active_map)
	
	#We spawn the tanks at the appropriate place :
	tank1.translation = active_map.get_node("SpawnPoints/SpawnPoint1").translation
	tank2.translation = active_map.get_node("SpawnPoints/SpawnPoint2").translation
	return


func _process(delta):
	healthP1.value = 100 * tank1.getHealthRatio()
	healthP2.value = 100 * tank2.getHealthRatio()

	var timingDashP1 = tank1.getDashDuration()
	# print("T1 : ", timingDashP1)
	dashP1.frame = int(4 * timingDashP1)
	var timingDashP2 = tank2.getDashDuration()
	dashP2.frame = int(4 * timingDashP2)

func getTankPositionByID(id : int) -> Vector3:
	if id == 1:
		return tank1.translation
	return tank2.translation
