extends Bullet

#La hauteur de l'apogée du projectile 
export(float) var _height

#La distance entre le point de départ et le point d'arrivée
export(float) var _distance

#La durée en l'air de la balle
export(float) var _duration

#Le temps qui s'est écoulé jusqu'ici
var _elapsedTime : float

#La distance actuelle de la balle au tank émetteur
var _currentDist : float

#La hauteur actuelle de la balle
var _currentHeight : float

#Le vecteur direction normalisé, le long duquel on déplace le projectile
var _norm : Vector3

#override
func initBullet(pos : Vector3, dir : Vector3, playerNumber : int) -> void :
	.initBullet(pos, dir, playerNumber)
	_currentDist = 0
	_currentHeight = translation.y
	_norm = _dir.normalized()
	_elapsedTime = 0


#Calcule la distance de la balle au char à l'instant t
func distance(t : float) -> float :
	return(_distance * t / _duration)


# La formule mathématique est - 4 * (hauteur * t^2 / durée^2) + 4 * hauteur * t / durée
# où hauteur et durée sont la hauteur maximale du tir et la durée du vol 
func height(t : float) -> float :
	return(-4 * _height * t * t / (_duration * _duration) + 4 * _height * t / _duration)


# A chaque étape, on calcule la hauteur et la distance auxquelles la balle devrait se trouver maintenant
# On soustrait aux coordonnées précédentes pour obtenir de combien faire avancer
# Puis on projette tout ça à l'aide de _dir normalisé (_norm) dans le plan vertical d'axe _dir, 
# On met à jour les quantités et on recommence 
func _process(delta) :
	_elapsedTime += delta
	var nextDist : float = distance(_elapsedTime)
	var nextHeight : float = height(_elapsedTime)
	var evolution : Vector3 = Vector3(nextDist,nextHeight, 0) - Vector3(_currentDist, _currentHeight, 0) 
	translate(Vector3(evolution.x*_norm.x, evolution.y, evolution.x*_norm.z))
	_currentDist = nextDist
	_currentHeight = nextHeight 


func _on_VisibilityNotifier_screen_exited():
	queue_free()


func _on_BellCurveBullet_body_entered(body):
	if body.has_method("damage")==true:
		body.damage(1)
	queue_free()

