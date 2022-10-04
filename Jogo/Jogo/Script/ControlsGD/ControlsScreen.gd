extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var sceene = load("res://ControlsScreen.gd")
# Called when the node enters the scene tree for the first time.
#func _process(delta):
var x:int
var y:int
onready var fullscreen:= get_node("Controller/Fullscreen")
onready var toggle:= get_node("Controller/Toggle Borderless")

func _ready():
	$Controller/Fullscreen.grab_focus()
func _on_Return_pressed():
	get_tree().current_scene.get_node("CanvasLayer/Controller").show()
	get_tree().reload_current_scene()


func _on_Fullscreen_pressed():
	
	if x == 0:
		OS.window_fullscreen = !OS.window_fullscreen
		fullscreen.text = " "
		x = 1
	elif x ==1:
		fullscreen.text = "X"
		OS.window_fullscreen = !OS.window_fullscreen
		x = 0
	pass # Replace with function body.


func _on_Toggle_Borderless_pressed():
	if y == 0:
		toggle.text = " "
		y = 1
	elif y ==1:
		toggle.text = "X"
		y = 0
	pass # Replace with function body.
