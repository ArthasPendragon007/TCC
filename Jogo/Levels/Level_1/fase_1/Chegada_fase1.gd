extends Area2D

onready var changer = get_parent().get_node("Transition_In")
export var path : String

func ready():
	pass

func _on_Chegada_fase1_body_entered(body: Node) -> void:
	if body.name == "Player":
		changer.change_scene(path)


func _on__body_entered(body):
	pass # Replace with function body.
	
func _on_historia_historia():
	changer.change_scene(path)
