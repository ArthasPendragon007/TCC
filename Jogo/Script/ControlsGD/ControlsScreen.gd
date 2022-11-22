extends Control

var x:bool
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var sceene = load("res://ControlsScreen.gd")
# Called when the node enters the scene tree for the first time.
#func _process(delta):
func _ready():
	$Controller/Return.grab_focus()
func _on_Return_pressed():
	get_tree().current_scene.get_node("CanvasLayer/Controller").show()
	queue_free()

func _on_tela_cheiona_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	x = !x
	if x == true:
		$tela_cheiona.text = "X"
	elif x == false:
		$tela_cheiona.text = " "


func _on_tela_sem_borda_pressed():
	OS.window_borderless = !OS.window_borderless
	x = !x
	if x == true:
		$tela_sem_borda.text = "X"
	elif x == false:
		$tela_sem_borda.text = " "



func _on_abaixa_volume_pressed():
	 $Volume/ProgressBar.value = $Volume/ProgressBar.value - 5



func _on_aumenta_volume_pressed():
	$Volume/ProgressBar.value = $Volume/ProgressBar.value + 5





func _on_ProgressBar_value_changed(value):
	if value == -30:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(0,value)
