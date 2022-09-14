extends Control

onready var start = get_node(".")

func _ready():
	$CanvasLayer/Controller/Return.grab_focus()
func _on_Return_pressed():
	if start:
		queue_free()

