extends Spatial
class_name Tank



func loadData(data : TankData):
	$Chassi.mesh = data.chassi.chassiMesh
	$Chassi.translation = data.chassi.chassiPos
	$Chassi.scale = data.chassi.chassiScale
	
	$Track.mesh = data.track.trackMesh
	$Track.translation = data.track.trackPos
	$Track.scale = data.track.trackScale
	
	$Turret.mesh = data.turret.turretMesh
	$Turret.translation = data.turret.turretPos
	$Turret.scale = data.turret.turretScale
	
	$Turret/Canon.mesh = data.turret.canonMesh
	$Turret/Canon.translation = data.turret.canonPos
	$Turret/Canon.scale = data.turret.canonScale
	
	pass
