extends Bullet
class_name ScharpnelBullet

var _childData : BulletData

var _speed : float

##la durée de vie de la balle
var _detonationTime : int

##la durée de vie écoulée de la balle 
var _elapsedTime  : float = 0


func initBullet(pos : Vector3, dir : Vector3, playerNumber : int, data : BulletData) -> void :
	.initBullet(pos, dir, playerNumber, data)
	var bulletData : SharpnelBulletData = data as SharpnelBulletData
	if bulletData == null :
		queue_free()
	else:
		_childData = bulletData.childData
		_speed = bulletData.speed
		_detonationTime = bulletData.detonationTime


##fait avancer la balle, puis fait détoner la balle au bout de detonationTime en 8 balles
##delta : le temps entre deux appels de cette fonction
func _process(delta):
	_elapsedTime += delta
	if _elapsedTime > _detonationTime :
		for i in range(8):
			var bullet : Bullet = _childData.bulletScene.instance()
			get_tree().current_scene.add_child(bullet)
			# 1 - playerNumber : La balle traverse le char émetteur et touche l'adversaire
			bullet.initBullet(self.global_transform.origin, 
					_dir.rotated(Vector3.UP, deg2rad(360*i/8)), _playerNumber, _childData)
		queue_free()
	translate(_dir * _speed * delta)


func _on_VisibilityNotifier_screen_exited():
	queue_free()



func _on_SchrapnelBullet_body_entered(body):
	#Que fait balle schrapnel si elle impacte quelque chose ?
	queue_free()
