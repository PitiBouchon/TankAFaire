extends Spatial
class_name DisplayTank


func updateDisplay(data : TankData) -> void:
	
	$Chassi.mesh = data.chassi.chassiMesh
	$Chassi.translation = data.chassi.chassiPos
	$Chassi.rotation_degrees = data.chassi.chassiRotation
	$Chassi.scale = data.chassi.chassiScale
	
	$Chassi/Track.mesh = data.track.trackMesh
	$Chassi/Track.translation = data.chassi.trackPos + data.track.trackPosOffset
	$Chassi/Track.rotation_degrees = data.track.trackRotation - data.chassi.chassiRotation
	$Chassi/Track.scale = data.track.trackScale  *  (data.chassi.chassiScale).inverse()
	
	$Turret.mesh = data.turret.turretMesh
	$Turret.translation = data.chassi.turretPos + data.turret.turretPosOffset
	$Turret.rotation_degrees = data.turret.turretRotation
	$Turret.scale = data.turret.turretScale
	
	$Turret/Canon.mesh = data.gun.gunMesh
	$Turret/Canon.translation = data.turret.gunPos
	$Turret/Canon.rotation_degrees = data.gun.gunRotation
	$Turret/Canon.scale = data.gun.gunScale
	
	return
