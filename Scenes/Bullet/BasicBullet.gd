extends Bullet
class_name BasicBullet

var _speed : float = 0


#override
func initBullet(pos : Vector3, dir : Vector3, playerNumber : int, data : BulletData) -> void :
	.initBullet(pos, dir, playerNumber, data)
	var bulletData : BasicBulletData = data as BasicBulletData
	if bulletData == null:
		queue_free()
	else :
		_speed = bulletData.speed


func _process(delta):
	translate(_dir * _speed * delta)


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_BasicBullet_body_entered(body : Node) -> void:
	if body.has_method("damage")==true:
		body.damage(1)
	queue_free()
	pass # Replace with function body.
