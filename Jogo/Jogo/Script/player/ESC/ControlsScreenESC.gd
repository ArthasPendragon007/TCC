extends Control

onready var start = get_node(".")
var x:int

func _ready():
	$CanvasLayer/Controller/Return.grab_focus()
func _on_Return_pressed():
	if start:
		queue_free()
		var EscScreenBack = load("res://Levels/scene/Player/Pause/ESC_player.tscn").instance()
		get_tree().current_scene.add_child (EscScreenBack)

#		get_node("CanvasLayer/Controller").hide()

#		get_tree().change_scene("res://Levels/scene/Player/Pause/ESC_player.tscn")

#		get_node(".").hide()
