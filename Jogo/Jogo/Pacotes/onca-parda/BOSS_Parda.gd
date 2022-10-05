extends KinematicBody2D

export var speed = 200
var velocity = Vector2.ZERO
var gravity = 600
var move_direction = -1
onready var sprite = get_node("sprites")
onready var anim = get_node("anim")
onready var hurtbox_col = get_node("Hurtbox/Collision")
#var timer := Timer.new()
#func _ready():
#	add_child(timer)

func _physics_process(delta: float) -> void:
	velocity.x = speed * move_direction
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity)
	
	if move_direction == 1:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

	if $ray_wall.is_colliding():
		sprite.flip_h != sprite.flip_h
		move_direction *= -1
		$ray_wall.scale.x *= -1
		$ray_wall2.scale.x *= -1

	if $ray_wall2.is_colliding():
		sprite.flip_h != sprite.flip_h
		move_direction *= -1
		$ray_wall2.scale.x *= -1
		$ray_wall.scale.x *= -1
	if abs(velocity.x) > 15:
		anim.play("Run")
	elif abs(velocity.x) == 0:
		anim.play("Idle")
	elif !is_on_floor():
		anim.play("Jump")
		sprite.frame = 2
#		timer.wait_time = 0.59
		if abs(velocity.y) > 10:
			sprite.frame = 2
# TESTES PARA CASO HAJA ANIMAÇÃO DE IDLE E RUN

#	if $ray_wall.is_colliding():
#		$anim.play("idle")

#func _on_anim_animation_finished(anim_name: String) -> void:
#	if anim_name = "idle":
#		sprite.flip_h != sprite.flip_h
#		$ray_wall.scale.x *= -1
#		move_direction *= -1
#		anim.play("run")
