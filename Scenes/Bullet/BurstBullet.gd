extends Bullet

export(PackedScene) var BasicBullet

export(float) var interBulletTime = 0.2

export(int) var amount = 5


func initBullet(pos : Vector3, dir : Vector3, playerNumber : int) -> void :
	.initBullet(pos, dir, playerNumber)
	for i in range(amount):
		var bullet : Bullet = BasicBullet.instance()
		get_tree().current_scene.add_child(bullet)
		#TODO : Suivre le déplacement du char
		bullet.initBullet(self.global_transform.origin, dir, playerNumber)
		yield(get_tree().create_timer(interBulletTime), "timeout")
	queue_free()
