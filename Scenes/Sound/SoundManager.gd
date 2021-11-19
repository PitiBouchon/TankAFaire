extends Node

var musicButton3 = load("res://Assets/Sound/bouton3.mp3")
var musicButton2 = load("res://Assets/Sound/bouton2.mp3")
var musicGong = load("res://Assets/Sound/gongdefin.mp3")


func play_button3():
	print("1")
	$Sound.stream = musicButton3
	$Sound.play()

func play_button2():
	print("2")
	$Sound.stream = musicButton2
	$Sound.play()

func play_gong():
	print("3")
	$Sound.stream = musicGong
	$Sound.play()
