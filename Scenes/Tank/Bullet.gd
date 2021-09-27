extends RigidBody
#The script used by the bullet

#When the bullet exits the screen :
func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_Bullet_body_entered(body: Node) -> void:
	if body.has_method("damage")==true:
		body.damage(1)
	queue_free()
	pass # Replace with function body.
