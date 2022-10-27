extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Trigger_PlayerEntered_Camera():
	$BossCam.current = true


func _on_BOSS_Parda_BossDead():
	$BossCam.current = false
