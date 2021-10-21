extends Bullet

export(float) var detectionRad

export(float) var damage

export(float) var countdown

export(float) var delay

var elapsedTime : float = 0

var triggered : bool = false

func initBullet(pos : Vector3, dir : Vector3, playerNumber : int) -> void :
	.initBullet(pos, dir, playerNumber)
	#scale = Vector3(detectionRad, detectionRad, detectionRad)
	$CollisionShape.shape.radius = detectionRad


func _process(delta):
	elapsedTime += delta
	if !triggered  && elapsedTime >= countdown :
		explode()

# Faut gérer les délais
func _on_Landmine_body_entered(body):
	triggered = true
	yield(get_tree().create_timer(delay), "timeout")
	explode()

func explode():
	var overlaps = get_overlapping_bodies()
	for target in overlaps:
		if target.has_method("damage"):
			target.damage(damage)
	queue_free()
