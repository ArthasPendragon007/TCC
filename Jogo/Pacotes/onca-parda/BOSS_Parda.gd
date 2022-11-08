extends KinematicBody2D

signal BossDead

func _ready():

	set_physics_process(false)

export var health = 23
export var speed = 300
var velocity = Vector2.ZERO
var gravity = 600
var move_direction = -1
onready var sprite = get_node("sprites")
onready var anim = get_node("anim")
onready var hurtbox_col = get_node("Hurtbox/Collision")
var timer := Timer.new()
var condic = true

#func _ready():
#	add_child(timer)


func _physics_process(delta: float) -> void:



	if condic:
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
	if $ray_wall.is_colliding() or $ray_wall2.is_colliding():
		$anim.play("idle")
		condic = false
		timer.wait_time = 3
		timer.one_shot = true
		
		timer.connect("timeout", self, "_on_timer_timeout")
		timer.start()
	if !$ray_wall.is_colliding() or !$ray_wall2.is_colliding():
		if abs(velocity.x) > 15:
			anim.play("Run")
		elif abs(velocity.x) < 15:
			anim.play("Idle")
		elif !is_on_floor():
			anim.play("Jump")
			sprite.frame = 2
			if abs(velocity.y) > 10:
				sprite.frame = 2
# TESTES PARA CASO HAJA ANIMAÇÃO DE IDLE E RUN

#
#func _on_anim_animation_finished(anim_name: String) -> void:
#	if !$ray_wall.is_colliding() or !$ray_wall2.is_colliding():
#		if abs(velocity.x) > 15:
#			anim.play("Run")
#		elif abs(velocity.x) < 15:
#			anim.play("Idle")
#		elif !is_on_floor():
#			anim.play("Jump")
#			sprite.frame = 2
#			if abs(velocity.y) > 10:
#				sprite.frame = 2
###

func _on_timer_timeout() -> void:
#		anim.play("run")
	condic = true



func _on_ArenaDoor2_DoorClosed():
	set_physics_process(true)
	add_child(timer)


func _on_Hitbox_body_entered(body):
#	hitted = true
	health -= 1
	for n in 4:
		sprite.modulate.a = 200
#		yield(get_tree(), "idle_frame")
		sprite.modulate.a = 1
#		yield(get_tree(), "idle_frame")
	body.velocity.y -= 400
#	yield(get_tree().create_timer(0.2), "timeout")
#	hitted = false
	print(health)
	if health < 1:
		emit_signal("BossDead")
		queue_free()
		get_node("Hitbox/Collision").set_deferred("disabled", true)
#	return true

func _on_ArenaDoor_DoorClosed():
	pass # Replace with function body.
