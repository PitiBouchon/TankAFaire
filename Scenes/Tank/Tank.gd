extends KinematicBody
class_name Tank

var _playerNumber : int
var _speed : float
var _target : Vector3
var _current_time : float 
var _reload_time :float = 1 #A METTRE DANS DATA DU CANON
var _health : int = 5#Je met à 5 pour le moment, à modif

export (PackedScene) var Projectile

func loadData(data : TankData, player : int) -> void:
	_playerNumber = player
	_current_time=0
	
	#On donne au tank ses collisions :
	self.set_collision_layer_bit(_playerNumber,true)
	if _playerNumber==1:
		self.set_collision_mask_bit(2,true)
	else:
		self.set_collision_mask_bit(1,true)
	
	$Chassi.mesh = data.chassi.chassiMesh
	$Chassi.translation = data.chassi.chassiPos
	$Chassi.scale = data.chassi.chassiScale
	
	$Chassi/Track.mesh = data.track.trackMesh
	$Chassi/Track.translation = data.track.trackPos
	$Chassi/Track.scale = data.track.trackScale
	
	$Turret.mesh = data.turret.turretMesh
	$Turret.translation = data.turret.turretPos
	$Turret.scale = data.turret.turretScale
	
	$Turret/Canon.mesh = data.turret.canonMesh
	$Turret/Canon.translation = data.turret.canonPos
	$Turret/Canon.scale = data.turret.canonScale
	
	_speed = computeSpeed(data)
	return

func computeSpeed(data : TankData) -> float:
	#need implementation
	return 10.0

func _process(delta):
	processChassi(delta)
	processTurret(delta)
	_current_time += delta
	pass


func processChassi(delta) -> void:
	var direction : Vector3 = Vector3.ZERO
	if _playerNumber == 1:
		if Input.is_action_pressed("player1_right"):
			direction.x += 1
		if Input.is_action_pressed("player1_left"):
			direction.x -= 1
		if Input.is_action_pressed("player1_up"):
			direction.z -= 1
		if Input.is_action_pressed("player1_down"):
			direction.z += 1
	
	if _playerNumber == 2:
		if Input.is_action_pressed("player2_right"):
			direction.x += 1
		if Input.is_action_pressed("player2_left"):
			direction.x -= 1
		if Input.is_action_pressed("player2_up"):
			direction.z -= 1
		if Input.is_action_pressed("player2_down"):
			direction.z += 1
	
	direction = direction.normalized()
	translate(direction * _speed * delta)
	
	$Chassi.rotation.y = acos(direction.z)
	if direction.x != 0 :
		$Chassi.rotation *= sign(direction.x)
	return

func updateTarget(pos : Vector3) -> void:
	_target = pos
	return

func processTurret(delta) -> void:
	var direction : Vector3 = _target - translation
	direction = direction.normalized()
	$Turret.rotation.y = acos(direction.z)
	if direction.x != 0 :
		$Turret.rotation *= sign(direction.x)
	#On gère le tir des tanks :
	if _playerNumber == 1:
		if Input.is_action_pressed("player1_shoot"):
			if _current_time > _reload_time :
				_current_time=0 #Permet de gérer le reload
				shoot(2) #comme c'est le tank 1 qui tire, le bullet va être vis-à-vis du tank 2 en layer/mask
	if _playerNumber == 2:
		if Input.is_action_pressed("player2_shoot"):
			if _current_time > _reload_time :
				_current_time=0
				shoot(1) #de même
	return

#This function handles the firing event
func shoot(playerNumber):
	var bullet : RigidBody = Projectile.instance()
	bullet.set_translation($Turret/Canon.global_transform.origin)
	get_tree().current_scene.add_child(bullet)
	bullet.apply_impulse(Vector3.ZERO,$Turret/Canon.global_transform.basis.z)
	bullet.set_collision_mask_bit(playerNumber,true)
	bullet.set_collision_mask_bit(playerNumber,true)
	pass

#This function IS CALLED BY THE PROJECTILE THAT HIT THE TANK
func damage(dmg):
	_health = _health-1
	if _health<0:
		queue_free()
		get_tree().reload_current_scene() #POUR LE MOMENT SI UN TANK MEURE LE JEU CRASH - DONC ON QUITTE
	pass
