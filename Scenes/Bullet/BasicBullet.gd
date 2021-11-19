extends Bullet
class_name BasicBullet

onready var mesh : MeshInstance = $MeshInstance


var _speed : float = 0


#override
func initBullet(pos : Vector3, dir : Vector3, playerNumber : int, data : BulletData) -> void :
	.initBullet(pos, dir, playerNumber, data)
	
	_dir = _dir.normalized()
	
	var bulletData : BasicBulletData = data as BasicBulletData
	if bulletData == null:
		queue_free()
	else :
		_speed = bulletData.speed
	
	
	mesh.rotation.y = acos(_dir.z)
	if _dir.x != 0 :
		mesh.rotation *= sign(_dir.x)


func _process(delta):
	translate(_dir * _speed * delta)


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_BasicBullet_body_entered(body : Node) -> void:
	if body.has_method("damage")==true:
		body.damage(_damage)
	queue_free()
	pass # Replace with function body.
