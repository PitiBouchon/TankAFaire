extends Bullet

var _childData : BulletData

var _spreadAngle : float
var _nbBullet : int

#override
func initBullet(pos : Vector3, dir : Vector3, playerNumber : int, data : BulletData) -> void :
	.initBullet(pos, dir, playerNumber, data)
	var bulletData : SpreadBulletData = data as SpreadBulletData
	if bulletData == null :
		queue_free()
	else :
		_childData = bulletData.childData
		_spreadAngle = bulletData.spreadAngle
		_nbBullet = bulletData.nbBullet
	
		var currentDir : Vector3 = dir
		currentDir = currentDir.rotated(Vector3.UP, -0.5*deg2rad(_spreadAngle))
		var subAngle : float = 1/(_nbBullet - 1)
		for i in range(_nbBullet): # -> rendre variable
			var bullet : Bullet = _childData.bulletScene.instance()
			get_tree().current_scene.add_child(bullet)
			bullet.initBullet(self.global_transform.origin, currentDir, playerNumber, _childData)
			currentDir = currentDir.rotated(Vector3.UP, subAngle*deg2rad(_spreadAngle))
		queue_free()
