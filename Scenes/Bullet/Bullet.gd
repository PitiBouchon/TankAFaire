extends Area
class_name Bullet


var _dir : Vector3
var _playerNumber : int;


func initBullet(pos : Vector3, dir : Vector3, playerNumber : int) -> void :
	translation = pos
	_dir = dir
	_playerNumber = playerNumber
	self.set_collision_mask_bit(0,false)
	self.set_collision_layer_bit(0,false)
	if playerNumber==1:
		self.set_collision_mask_bit(2,true)
		self.set_collision_layer_bit(2,true)
	else:
		self.set_collision_mask_bit(1,true)
		self.set_collision_layer_bit(1,true)
