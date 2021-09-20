extends Spatial
class_name DisplayTank


func updateDisplay(data : TankData) -> void:
	
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
	
	return
