extends RayCast

export(float) var duration = 3

var elapsedTime : float = 0

var hasStartedDisappearing : bool = false

func _ready():
	set_physics_process(true)
	appear()

func appear():
	$Tween.stop_all()
	$Tween.interpolate_property($MeshInstance.mesh, "top_radius", 0, 0.5, 0.2)
	$Tween.interpolate_property($MeshInstance.mesh, "bottom_radius", 0, 0.5, 0.2)
	$Tween.start()

func disappear():
	$Tween.stop_all()
	$Tween.interpolate_property($MeshInstance.mesh, "top_radius", 0.5, 0, 0.2)
	$Tween.interpolate_property($MeshInstance.mesh, "bottom_radius", 0.5, 0, 0.2)
	$Tween.start()
	yield(get_tree().create_timer(0.2), "timeout")
	queue_free()

func _physics_process(delta):
	elapsedTime += delta
	if elapsedTime >= duration and !hasStartedDisappearing :
		hasStartedDisappearing = true
		disappear()
	else:
		var castPoint : Vector3 = cast_to
		force_raycast_update()
		
		if is_colliding():
			castPoint = to_local(get_collision_point())
	
		update_cylinder(castPoint)
		
func update_cylinder(castPoint):
	var origin : Vector3  = to_local(Vector3.ZERO)
	var end : Vector3 = castPoint
	var middle : Vector3 = (origin + end)/2
	$MeshInstance.translation = middle
	var newHeight : float = origin.distance_to(end)
	$MeshInstance.mesh.set("height",newHeight)
	
