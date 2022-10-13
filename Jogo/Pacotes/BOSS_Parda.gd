extends KinematicBody2D

export var speed = 200
var velocity = Vector2.ZERO
var gravity = 1000
var move_direction = -1
onready var hurtbox_col = get_node("Hurtbox/Collision")

func _physics_process(delta: float) -> void:
	velocity.x = speed * move_direction
	
	velocity = move_and_slide(velocity)
	
	if move_direction == 1:
		$textura.flip_h = false
	else:
		$textura.flip_h = true

	if $ray_wall.is_colliding():
		$textura.flip_h != $textura.flip_h
		move_direction *= -1
		$ray_wall.scale.x *= -1
		$ray_wall2.scale.x *= -1

	if $ray_wall2.is_colliding():
		$textura.flip_h != $textura.flip_h
		move_direction *= -1
		$ray_wall2.scale.x *= -1
		$ray_wall.scale.x *= -1


# TESTES PARA CASO HAJA ANIMAÇÃO DE IDLE E RUN

#	if $ray_wall.is_colliding():
#		$anim.play("idle")

#func _on_anim_animation_finished(anim_name: String) -> void:
#	if anim_name = "idle":
#		$textura.flip_h != $textura.flip_h
#		$ray_wall.scale.x *= -1
#		move_direction *= -1
#		anim.play("run")
