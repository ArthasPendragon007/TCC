extends Control


func _ready():
	$Controller/Return.grab_focus()
	
func _on_Return_pressed():
	get_tree().current_scene.get_node("CanvasLayer/Controller").show()
	queue_free()
