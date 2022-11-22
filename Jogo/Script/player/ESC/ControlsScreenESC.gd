extends Control

onready var start = get_node(".")
var x:bool

func _ready():
	$CanvasLayer/Controller/Return.grab_focus()
func _on_Return_pressed():
	if start:
		queue_free()
		var EscScreenBack = load("res://Levels/scene/Player/Pause/ESC_player.tscn").instance()
		get_tree().current_scene.add_child (EscScreenBack)



func _on_tela_cheiona_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	x = !x
	if x == true:
		$CanvasLayer/tela_cheiona.text = "X"
	elif x == false:
		$CanvasLayer/tela_cheiona.text = " "
