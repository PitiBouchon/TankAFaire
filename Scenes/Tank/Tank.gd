extends KinematicBody
class_name Tank


export (float) var _angleAdjustSpeed = 90
export (float) var _minDmg = 1 

onready var chassi = $Chassi
onready var track = $Chassi/Track
onready var turret = $Turret
onready var gun = $Turret/Canon
onready var mainMuzzle = $Turret/Canon/mainMuzzle
onready var secMuzzle = $Turret/secMuzzle


var _playerNumber : int

var _speed : float
var _health : float
var _armor : float
var _target : Vector3

#chassi
var _chassiDirection : Vector3
var _chassiFreezDuration : float
var _chassiFreezTimer : float
var _chassiAngleOffset : float

#turret
var _baseTurretOffset : Vector3
var _turretFreezDuration : float
var _turretFreezTimer : float
var _angleAdjust : float
var _turretAngleOffset : float

# Main gun
var _bulletData : BulletData
var _mainReloadTimer : float 
var _mainReloadCooldown:float

# Secondary gun
var _secBulletData : BulletData
var _secReloadTimer : float
var _secReloadCooldown : float 

#dash
var _isDashing : bool
var _dashSpeed : float
var _dashDuration : float
var _dashTimer : float
var _dashCooldown : float
var _dashDirection : Vector3


func loadData(data : TankData, player : int) -> void:
	_playerNumber = player
	
	_speed = computeSpeed(data)
	_health = computeHealth(data)
	_armor = computeArmor(data)
	
	_chassiDirection = Vector3.ZERO
	_chassiFreezDuration = data.gun.bulletData.chassiFreezTime
	_chassiFreezTimer = _chassiFreezDuration
	_chassiAngleOffset = data.chassi.chassiRotation.y;
	
	_baseTurretOffset = data.chassi.turretPos + data.turret.turretPosOffset
	_turretFreezDuration = data.gun.bulletData.turretFreezTime
	_turretFreezTimer = _turretFreezDuration
	_angleAdjust = 0
	_turretAngleOffset = data.turret.turretRotation.y
	
	mainMuzzle.translation = data.gun.relativeMuzzlePosition
	_bulletData = data.gun.bulletData 
	_mainReloadTimer = 0
	_mainReloadCooldown= data.gun.reloadTime
	
	secMuzzle.translation = data.turret.secGunPos
	_secBulletData = data.turret.secBulletData
	_secReloadTimer = 0
	_secReloadCooldown = data.turret.secCooldown
	
	
	_isDashing = false
	_dashSpeed = data.engine.dashSpeed
	_dashDuration = data.engine.dashDistance / _dashSpeed
	_dashTimer = 0
	_dashCooldown = data.engine.dashCooldown

	#On donne au tank ses collisions :
	self.set_collision_layer_bit(_playerNumber,true)
	self.set_collision_mask_bit(_playerNumber, true)
	
	self.set_collision_layer_bit(0,true)
	self.set_collision_mask_bit(0, true)
	
	#meshes
	chassi.mesh = data.chassi.chassiMesh
	chassi.translation = data.chassi.chassiPos
	chassi.rotation_degrees = data.chassi.chassiRotation
	chassi.scale = data.chassi.chassiScale
	
	track.mesh = data.track.trackMesh
	track.translation = data.chassi.trackPos + data.track.trackPosOffset 
	track.rotation_degrees = data.track.trackRotation - data.chassi.chassiRotation
	track.scale = data.track.trackScale *  vec3RotInv(data.chassi.chassiScale, data.chassi.chassiRotation)
	
	turret.mesh = data.turret.turretMesh
	turret.translation = data.chassi.turretPos + data.turret.turretPosOffset
	turret.rotation_degrees = data.turret.turretRotation
	turret.scale = data.turret.turretScale
	
	gun.mesh = data.gun.gunMesh
	gun.translation = data.turret.gunPos
	gun.rotation_degrees = data.gun.gunRotation
	gun.scale = data.gun.gunScale
	
	return

func computeSpeed(data : TankData) -> float:
	var weight = data.turret.weight + data.chassi.weight + data.track.weight + data.gun.weight + data.engine.weight
	var power = data.engine.horsePower
	var speedFactor = data.track.speedFactor
	return speedFactor * power / weight

func computeHealth(data : TankData) -> float:
	return data.turret.healthPoints + data.chassi.healthPoints

func computeArmor(data : TankData) -> float:
	return 0.5*data.turret.armor + 0.5*data.chassi.armor



func _process(delta):
	processChassi(delta)
	processTurret(delta)
	_mainReloadTimer += delta
	_secReloadTimer += delta
	_dashTimer += delta
	_chassiFreezTimer += delta
	_turretFreezTimer += delta
	_target = get_parent().getTankPositionByID(3-_playerNumber)
	pass


func processChassi(delta) -> void:
	
	var inputPressed : bool = false
	
	if _playerNumber == 1:
		if Input.is_action_pressed("player1_right"):
			_chassiDirection.x = 1
			inputPressed = true
		if Input.is_action_pressed("player1_left"):
			_chassiDirection.x = -1
			inputPressed = true
		if Input.is_action_pressed("player1_up"):
			_chassiDirection.z = -1
			inputPressed = true
		if Input.is_action_pressed("player1_down"):
			_chassiDirection.z = 1
			inputPressed = true
	
	if _playerNumber == 2:
		if Input.is_action_pressed("player2_right"):
			_chassiDirection.x = 1
			inputPressed = true
		if Input.is_action_pressed("player2_left"):
			_chassiDirection.x = -1
			inputPressed = true
		if Input.is_action_pressed("player2_up"):
			_chassiDirection.z = -1
			inputPressed = true
		if Input.is_action_pressed("player2_down"):
			_chassiDirection.z = 1
			inputPressed = true
	
	_chassiDirection = _chassiDirection.normalized()
	
	if _playerNumber == 1 :
		if Input.is_action_just_pressed("player1_dash") && !_isDashing && _dashTimer > _dashCooldown:
			_isDashing = true
			_dashTimer = 0
			_dashDirection = _chassiDirection
	
	if _playerNumber == 2 :
		if Input.is_action_just_pressed("player2_dash") && !_isDashing && _dashTimer > _dashCooldown:
			_isDashing = true
			_dashTimer = 0
			_dashDirection = _chassiDirection
	
	if _chassiFreezTimer > _chassiFreezDuration :
		if _isDashing :
			processDash()
		elif inputPressed :
			move_and_slide(_chassiDirection * _speed)
		
		chassi.rotation.y = acos(_chassiDirection.z)
		if _chassiDirection.x != 0 :
			chassi.rotation *= sign(_chassiDirection.x)
		
		chassi.rotation.y += deg2rad(_chassiAngleOffset)

func processDash() -> void:
	if _dashTimer > _dashDuration :
		_isDashing = false
		return
	move_and_slide(_dashDirection * _dashSpeed )
	pass


func processTurret(delta) -> void:
	var positionOffset : Vector3 = _baseTurretOffset.rotated(Vector3.UP, chassi.rotation.y)
	turret.translation = positionOffset
	
	if _turretFreezTimer > _turretFreezDuration :
		var direction : Vector3 = _target - translation
		direction = direction.normalized()
		
		if _playerNumber == 1:
			if Input.is_action_pressed("player1_rotLeft"):
				_angleAdjust += _angleAdjustSpeed * delta
			elif Input.is_action_pressed("player1_rotRight") : 
				_angleAdjust -= _angleAdjustSpeed * delta
			else:
				_angleAdjust = 0
		
		if _playerNumber == 2:
			if Input.is_action_pressed("player2_rotLeft"):
				_angleAdjust += _angleAdjustSpeed * delta
			elif Input.is_action_pressed("player2_rotRight") : 
				_angleAdjust -= _angleAdjustSpeed * delta
			else:
				_angleAdjust = 0
		
		turret.rotation.y = acos(direction.z)
		if direction.x != 0 :
			turret.rotation *= sign(direction.x)
		turret.rotation.y += deg2rad(_angleAdjust)
		turret.rotation.y += deg2rad(_turretAngleOffset)
		
		#On gère le tir des tanks :
		if _playerNumber == 1:
			if Input.is_action_pressed("player1_shoot"):
				if _mainReloadTimer > _mainReloadCooldown:
					_mainReloadTimer=0 #Permet de gérer le reload
					mainShoot() 
			if Input.is_action_just_pressed("player1_secShoot"):
				if _secReloadTimer > _secReloadCooldown:
					_secReloadTimer = 0
					secShoot()
			
		if _playerNumber == 2:
			if Input.is_action_pressed("player2_shoot"):
				if _mainReloadTimer > _mainReloadCooldown:
					_mainReloadTimer=0
					mainShoot() 
			if Input.is_action_just_pressed("player2_secShoot"):
				if _secReloadTimer > _secReloadCooldown:
					_secReloadTimer = 0
					secShoot()

#This function handles the firing event
func mainShoot() -> void:
	var bullet : Bullet = _bulletData.bulletScene.instance()
	if !_bulletData.relativeToGun:
		get_tree().current_scene.add_child(bullet)
		bullet.initBullet(mainMuzzle.global_transform.origin, gun.global_transform.basis.z, _playerNumber, _bulletData)
	else:
		gun.add_child(bullet)
		bullet.initBullet(mainMuzzle.translation, Vector3.BACK, _playerNumber, _bulletData)
		bullet.scale.x *= (1 / turret.scale.x) * (1 / gun.scale.x)
		bullet.scale.y *= (1 / turret.scale.y) * (1 / gun.scale.y)
		bullet.scale.z *= (1 / turret.scale.z) * (1 / gun.scale.z)
	
	if _bulletData.stopChassiMovement :
		_chassiFreezTimer = 0
	
	if _bulletData.stopTurretRotation :
		_turretFreezTimer = 0


func secShoot() -> void:
	var bullet : Bullet = _secBulletData.bulletScene.instance()
	if !_bulletData.relativeToGun:
		get_tree().current_scene.add_child(bullet)
		bullet.initBullet(secMuzzle.global_transform.origin, turret.global_transform.basis.z, _playerNumber, _secBulletData)
	else:
		gun.add_child(bullet)
		bullet.initBullet(secMuzzle.translation, Vector3.BACK, _playerNumber, _bulletData)
		bullet.scale.x *= (1 / turret.scale.x)
		bullet.scale.y *= (1 / turret.scale.y)
		bullet.scale.z *= (1 / turret.scale.z)
	
	if _secBulletData.stopChassiMovement :
		_chassiFreezTimer = 0
	
	if _secBulletData.stopTurretRotation :
		_turretFreezTimer = 0


#This function IS CALLED BY THE PROJECTILE THAT HIT THE TANK
func damage(dmg) -> void:
	_health -= max(dmg - _armor, _minDmg)
	if _health<=0:
		queue_free()
		get_tree().reload_current_scene() #POUR LE MOMENT SI UN TANK MEURE LE JEU CRASH - DONC ON QUITTE
	pass





func vec3Inv(vector : Vector3) -> Vector3 :
	return Vector3(1/ vector.x, 1/ vector.y, 1/ vector.z)

func vec3RotInv(vector : Vector3, rot : Vector3) -> Vector3 :
	var invVect := vec3Inv(vector)
	invVect = invVect.rotated(Vector3(1,0,0), deg2rad(-rot.x))
	invVect = invVect.rotated(Vector3(0,1,0), deg2rad(-rot.y))
	invVect = invVect.rotated(Vector3(0,0,1), deg2rad(-rot.z))
	return invVect
