extends Bullet

export (float) var speed


#override
func initBullet(pos : Vector3, dir : Vector3, playerNumber : int) -> void :
	.initBullet(pos, dir, playerNumber)


func _process(delta):
	translate(_dir * speed * delta)


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_BasicBullet_body_entered(body : Node) -> void:
	if body.has_method("damage")==true:
		body.damage(1)
	queue_free()
	pass # Replace with function body.
