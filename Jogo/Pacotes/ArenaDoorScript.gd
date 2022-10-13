extends StaticBody2D

signal DoorClosed

func ready():
	pass


func _on_Trigger_PlayerEntered():
	$anim.play("enabled")
	emit_signal("DoorClosed")


func _on_BOSS_Parda_BossDead():
	$anim.play("desativar")
