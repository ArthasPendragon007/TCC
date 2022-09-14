extends CanvasLayer

func change_scene(path, delay = 1):
	$transition_fx.interpolate_property($overlay, "progress", 0.0, 1.0, 5.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	$transition_fx.start()
	yield($transition_fx, "tween_completed")
	assert(get_tree().change_scene(path) == OK)
	

onready var overlay = get_node("overlay")
onready var animation = get_node("overlay/AnimationPlayer")
onready var trans = get_node(".")


#
#func _ready():
#	animation.play("fade")
#
#func _on_AnimationPlayer_animation_finished(anim_name):
#	get_tree().queue_delete(trans)
#	trans.queue_free()
#	emit_signal("fineshed")
#
