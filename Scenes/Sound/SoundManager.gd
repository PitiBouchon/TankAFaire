extends Node

var musicButton3 = load("res://Assets/Sound/bouton3.mp3")
var musicButton2 = load("res://Assets/Sound/bouton2.mp3")


func play_button3():
	$Sound.stream = musicButton3
	$Sound.play()

func play_button2():
	$Sound.stream = musicButton2
	$Sound.play()
