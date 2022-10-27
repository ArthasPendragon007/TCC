extends Control


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
	get_tree().reload_current_scene()
