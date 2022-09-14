extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _on_Fall_zone_body_entered(body):
	print (body)
	get_tree ().reload_current_scene()
