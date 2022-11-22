extends Node

var bgMusic = load ("res://Music/musica_bg_tcc.mp3")

func _ready():
	pass 

func play_music():
	
	$MusicBg.stream = bgMusic
	$MusicBg.play()
