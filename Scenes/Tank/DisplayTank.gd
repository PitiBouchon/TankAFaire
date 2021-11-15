extends Spatial
class_name DisplayTank


func updateDisplay(data : TankData) -> void:
	
	$Chassi.mesh = data.chassi.chassiMesh
	$Chassi.translation = data.chassi.chassiPos
	$Chassi.rotation_degrees = data.chassi.chassiRotation
	$Chassi.scale = data.chassi.chassiScale
	
	$Chassi/Track.mesh = data.track.trackMesh
	$Chassi/Track.scale = data.track.trackScale  *  vec3RotInv(data.chassi.chassiScale, data.chassi.chassiRotation)
	$Chassi/Track.translation = data.chassi.trackPos + data.track.trackPosOffset
	$Chassi/Track.rotation_degrees = data.track.trackRotation - data.chassi.chassiRotation
	
	
	$Turret.mesh = data.turret.turretMesh
	$Turret.translation = data.chassi.turretPos + data.turret.turretPosOffset
	$Turret.rotation_degrees = data.turret.turretRotation
	$Turret.scale = data.turret.turretScale
	
	$Turret/Canon.mesh = data.gun.gunMesh
	$Turret/Canon.translation = data.turret.gunPos
	$Turret/Canon.rotation_degrees = data.gun.gunRotation
	$Turret/Canon.scale = data.gun.gunScale
	
	return


func vec3Inv(vector : Vector3) -> Vector3 :
	return Vector3(1/ vector.x, 1/ vector.y, 1/ vector.z)

func vec3RotInv(vector : Vector3, rot : Vector3) -> Vector3 :
	var invVect := vec3Inv(vector)
	invVect = invVect.rotated(Vector3(1,0,0), deg2rad(-rot.x))
	invVect = invVect.rotated(Vector3(0,1,0), deg2rad(-rot.y))
	invVect = invVect.rotated(Vector3(0,0,1), deg2rad(-rot.z))
	return invVect
