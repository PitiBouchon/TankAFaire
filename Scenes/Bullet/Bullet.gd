extends Area
class_name Bullet

var _dir : Vector3

func initBullet(pos : Vector3, dir : Vector3, playerNumber : int, parameter : float) -> void :
	translation = pos
	_dir = dir
	if playerNumber==1:
		self.set_collision_mask_bit(2,true)
		self.set_collision_layer_bit(2,true)
	else:
		self.set_collision_mask_bit(1,true)
		self.set_collision_layer_bit(1,true)
