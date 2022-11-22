extends KinematicBody2D

export var health = 1
var gravity:int = 600
var velocity = Vector2.ZERO
var dano = false
#var x:bool = true
func _physics_process(delta: float) -> void:
	velocity.x += gravity * delta
#	if health >= 0:
##		$anims.play("Idle")
#		pass

	if $RayCast2D.is_colliding():
#		x = false
#		$anims.stop()
		var dano = true
		$anims.play("Danao")
		yield($anims, "animation_finished")
	else:
		var dano = false
		if dano == false and health >= 0:
			$anims.play("Idle")


func _on_Hitbox_Macaco_body_entered(body):
	health -= 1
	
	if health < 0:
		$anims.play("Morto")

		
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()
		get_node("Hitbox_Macaco/Collison").set_deferred("disabled", true)


func _on_anims_animation_finished(anim_name):
	if $anims.current_animation == "Danao":
#		x = true
		$anims.play("Idle")
