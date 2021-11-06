extends Bullet
class_name BurstBullet

var _childData : BulletData

var _interBulletTime : float

var _amount : int


func initBullet(pos : Vector3, dir : Vector3, playerNumber : int, data : BulletData) -> void :
	.initBullet(pos, dir, playerNumber, data)
	
	var bulletData : BurstBulletData = data as BurstBulletData
	
	if bulletData == null :
		queue_free()
	else:
		_childData = bulletData.childData
		_interBulletTime = bulletData.interBulletTime
		_amount = bulletData.amount
		
		for i in range(_amount):
			var bullet : Bullet = _childData.bulletScene.instance()
			get_tree().current_scene.add_child(bullet)
			#TODO : Suivre le déplacement du char
			bullet.initBullet(self.global_transform.origin, dir, playerNumber, _childData)
			yield(get_tree().create_timer(_interBulletTime), "timeout")
		queue_free()
