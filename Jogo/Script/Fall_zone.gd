extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var FakeInterface = load("res://Levels/scene/GAME OVER/game_over.tscn").instance()
func _on_Fall_zone_body_entered(body):

	print (body)
	get_tree().paused = !get_tree().paused
	get_tree().current_scene.add_child(FakeInterface)
