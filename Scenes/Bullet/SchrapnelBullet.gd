extends Bullet

export(PackedScene) var BasicBullet

export (float) var speed

##la durée de vie de la balle
export(float) var detonationTime = 3

##la durée de vie écoulée de la balle 
var elapsedTime  : float = 0


func initBullet(pos : Vector3, dir : Vector3, playerNumber : int) -> void :
	.initBullet(pos, dir, playerNumber)


##fait avancer la balle, puis fait détoner la balle au bout de detonationTime en 8 balles
##delta : le temps entre deux appels de cette fonction
func _process(delta):
	elapsedTime += delta
	if elapsedTime > detonationTime :
		for i in range(8):
			var bullet : Bullet = BasicBullet.instance()
			get_tree().current_scene.add_child(bullet)
			# 1 - playerNumber : La balle traverse le char émetteur et touche l'adversaire
			bullet.initBullet(self.global_transform.origin, 
					_dir.rotated(Vector3.UP, deg2rad(360*i/8)), _playerNumber)
		queue_free()
	translate(_dir * speed * delta)


func _on_VisibilityNotifier_screen_exited():
	queue_free()



func _on_SchrapnelBullet_body_entered(body):
	#Que fait balle schrapnel si elle impacte quelque chose ?
	queue_free()
