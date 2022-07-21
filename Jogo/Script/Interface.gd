extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var event:bool

func _ready() -> void:
	$Controller/StartBtn.call("grab_focus")
	if get_tree():
		show()
#	get_node("Controller").connect("pressed",self,"_on_Controller_pressed")
#	$Controller/StartBtn.grab_focus()
func _on_StartBtn_pressed() -> void:
	get_tree().change_scene("res://Test.tscn")
func _on_ControlsBtn_pressed() -> void:
	var ControlScreen = preload("res://Controls.tscn").instance()
	get_tree().current_scene.add_child (ControlScreen)
	_on_Controller_hide()
func _on_SettingsBtn_pressed() -> void:
#	breakpoint
	var ControlScreen = load("res://Scene/SettingsScreen.tscn").instance()
	get_tree().current_scene.add_child (ControlScreen)
	_on_Controller_hide()
func _on_QuitBtn_pressed() -> void:
	get_tree().quit()


func _on_Controller_hide() -> void:
#	show()
	get_node("Controller").hide()
#func _on_controller_show() -> void
