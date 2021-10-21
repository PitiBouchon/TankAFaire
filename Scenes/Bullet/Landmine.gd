extends Bullet

export(float) var detectionRad

export(float) var damage

export(float) var countdown

export(float) var delay

var elapsedTime : float = 0

func initBullet(pos : Vector3, dir : Vector3, playerNumber : int) -> void :
	.initBullet(pos, dir, playerNumber)
	#scale = Vector3(detectionRad, detectionRad, detectionRad)
	$CollisionShape.shape.radius = detectionRad

func _process(delta):
	elapsedTime += delta
	if elapsedTime >= countdown :
		print("Pffffffuit")
		queue_free()


func _on_Landmine_body_entered(body):
	print("Sup'")
	if body.has_method("damage")==true:
		body.damage(5)
		print("Kaboum !")
	queue_free()
