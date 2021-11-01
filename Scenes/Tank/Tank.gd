extends KinematicBody
class_name Tank

var _playerNumber : int

var _speed : float
var _health : int
var _target : Vector3

# reaload
var _reloadTimer : float 
var _realoadCooldown:float

#dash
var _isDashing : bool
var _dashSpeed : float
var _dashDuration : float
var _dashTimer : float
var _dashCooldown : float
var _dashDirection : Vector3

#bullet
var _muzzelOffset : Vector3
var _projectile : PackedScene

func loadData(data : TankData, player : int) -> void:
	_playerNumber = player
	
	_speed = computeSpeed(data)
	_health = computeHealth(data)
	
	_reloadTimer = 0
	_realoadCooldown= data.turret.realoadTime
	
	_isDashing = false
	_dashSpeed = data.engine.dashSpeed
	_dashDuration = data.engine.dashDistance / _dashSpeed
	_dashTimer = 0
	_dashCooldown = data.engine.dashCooldown
	
	_muzzelOffset = data.turret.relativeMuzzlePosition
	_projectile = data.turret.bulletScene
	
	#On donne au tank ses collisions :
	self.set_collision_layer_bit(_playerNumber,true)
	self.set_collision_mask_bit(_playerNumber, true)
	
	self.set_collision_layer_bit(0,true)
	self.set_collision_mask_bit(0, true)
	
	#meshes
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
	
	return

func computeSpeed(data : TankData) -> float:
	#need implementation
	return 10.0

func computeHealth(data : TankData) -> float:
	return data.turret.healthPoints + data.chassi.healthPoints



func _process(delta):
	processChassi(delta)
	processTurret(delta)
	_reloadTimer += delta
	_dashTimer += delta
	_target = get_parent().getTankPositionByID(3-_playerNumber)
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
	
	if _playerNumber == 1 :
		if Input.is_action_just_pressed("player1_dash") && !_isDashing && _dashTimer > _dashCooldown:
			_isDashing = true
			_dashTimer = 0
			_dashDirection = direction
	
	if _playerNumber == 2 :
		if Input.is_action_just_pressed("player2_dash") && !_isDashing && _dashTimer > _dashCooldown:
			_isDashing = true
			_dashTimer = 0
			_dashDirection = direction
	
	if _isDashing :
		processDash()
	else:
		move_and_slide(direction * _speed)
	
	$Chassi.rotation.y = acos(direction.z)
	if direction.x != 0 :
		$Chassi.rotation *= sign(direction.x)
	return

func processDash() -> void:
	if _dashTimer > _dashDuration :
		_isDashing = false
		return
	move_and_slide(_dashDirection * _dashSpeed )
	pass

func processTurret(delta) -> void:
	var direction : Vector3 = _target - translation
	direction = direction.normalized()
	$Turret.rotation.y = acos(direction.z)
	if direction.x != 0 :
		$Turret.rotation *= sign(direction.x)
	#On gère le tir des tanks :
	if _playerNumber == 1:
		if Input.is_action_pressed("player1_shoot"):
			if _reloadTimer > _realoadCooldown:
				_reloadTimer=0 #Permet de gérer le reload
				shoot() 
	if _playerNumber == 2:
		if Input.is_action_pressed("player2_shoot"):
			if _reloadTimer > _realoadCooldown:
				_reloadTimer=0
				shoot() 
	return

#This function handles the firing event
func shoot() -> void:
	var bullet : Bullet = _projectile.instance()
	get_tree().current_scene.add_child(bullet)
	bullet.initBullet($Turret/Canon.global_transform.origin + _muzzelOffset, $Turret/Canon.global_transform.basis.z, _playerNumber)
	pass

#This function IS CALLED BY THE PROJECTILE THAT HIT THE TANK
func damage(dmg) -> void:
	_health = _health-dmg
	if _health<=0:
		queue_free()
		get_tree().reload_current_scene() #POUR LE MOMENT SI UN TANK MEURE LE JEU CRASH - DONC ON QUITTE
	pass
