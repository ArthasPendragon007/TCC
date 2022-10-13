extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var event
# Called when the node enters the scene tree for the first time.
func _ready():
	$Controller/startBtn._input(event)

#func _input() -> void:
	#if is_action_pressed("ui_accept"):
		#grab_focus()
