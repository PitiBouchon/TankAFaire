extends Bullet

export(PackedScene) var BasicBullet

export(float) var spreadAngle = 90;

#override
func initBullet(pos : Vector3, dir : Vector3, playerNumber : int) -> void :
	.initBullet(pos, dir, playerNumber)
	var currentDir : Vector3 = dir
	currentDir = currentDir.rotated(Vector3.UP, -0.5*deg2rad(spreadAngle))
	for i in range(5):
		var bullet : Bullet = BasicBullet.instance()
		get_tree().current_scene.add_child(bullet)
		bullet.initBullet(self.global_transform.origin, currentDir, playerNumber)
		currentDir = currentDir.rotated(Vector3.UP, 0.25*deg2rad(spreadAngle))
	queue_free()
