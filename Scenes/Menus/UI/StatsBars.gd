extends Control
class_name StatsBars


onready var health : TextureProgress = $Health/TextureProgress
onready var damage : TextureProgress = $Damage/TextureProgress
onready var speed : TextureProgress = $Speed/TextureProgress
onready var armor : TextureProgress = $Armor/TextureProgress


func UpdateStats(healtRatio : float, damageRatio : float, speedRatio : float, armorRatio : float) -> void:
	health.value = healtRatio * 100
	damage.value = damageRatio * 100
	speed.value = speedRatio * 100
	armor.value = armorRatio * 100
	print("update stats")
	return

