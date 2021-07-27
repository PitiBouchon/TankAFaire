extends Spatial
class_name Tank

var _playerNumber : int
var _speed : float

func loadData(data : TankData, player : int) -> void:
	_playerNumber = player
	
	$Chassi.mesh = data.chassi.chassiMesh
	$Chassi.translation = data.chassi.chassiPos
	$Chassi.scale = data.chassi.chassiScale
	
	$Chassi/Track.mesh = data.track.trackMesh
	$Chassi/Track.translation = data.track.trackPos
	$Chassi/Track.scale = data.track.trackScale
	
	$Turret.mesh = data.turret.turretMesh
	$Turret.translation = data.turret.turretPos
	$Turret.scale = data.turret.turretScale
	
	$Turret/Canon.mesh = data.turret.canonMesh
	$Turret/Canon.translation = data.turret.canonPos
	$Turret/Canon.scale = data.turret.canonScale
	
	_speed = computeSpeed(data)
	return

func computeSpeed(data : TankData) -> float:
	#need implementation
	return 10.0


func _process(delta):
	var direction : Vector3 = Vector3.ZERO
	if(_playerNumber == 1):
		if Input.is_action_pressed("ui_right"):
			direction.x += 1
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
		if Input.is_action_pressed("ui_up"):
			direction.z -= 1
		if Input.is_action_pressed("ui_down"):
			direction.z += 1
	
	direction = direction.normalized()
	translate(direction * _speed * delta)
	
	$Chassi.rotation.y = direction.angle_to(Vector3.FORWARD)
	
	
	pass
