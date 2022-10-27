extends Control

var life_size = 36

func on_change_life(player_health):
	$Lifes.rect_size.x = Global.player_health * life_size
