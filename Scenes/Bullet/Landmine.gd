extends Bullet
class_name Landmine

#Le rayon de détection de la mine
var _detectionRad : float

#Le compte à rebours après la pose avant l'explosion autonome de la mine
var _countdown : float

#Le délai entre l'activation manuelle et l'explosion de la bombe
var _delay : float

var _elapsedTime : float = 0

var _triggered : bool = false

func initBullet(pos : Vector3, dir : Vector3, playerNumber : int, data : BulletData) -> void :
	.initBullet(Vector3(pos.x, 0, pos.y), dir, playerNumber, data)
	var bulletData : LandmineData = data as LandmineData
	
	if bulletData == null :
		queue_free()
	else:
		_detectionRad = bulletData.detectionRad
		_countdown = bulletData.countdown
		_delay = bulletData.delay
		
		$CollisionShape.shape.radius = _detectionRad


func _process(delta):
	_elapsedTime += delta
	if !_triggered  && _elapsedTime >= _countdown :
		explode()

# Faut gérer les délais
func _on_Landmine_body_entered(body):
	_triggered = true
	yield(get_tree().create_timer(_delay), "timeout")
	explode()

func explode():
	var overlaps = get_overlapping_bodies()
	for target in overlaps:
		if target.has_method("damage"):
			target.damage(_damage)
	queue_free()
