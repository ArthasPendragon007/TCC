extends KinematicBody2D

onready var velocity = Vector2.ZERO
export(int) var GRAVITY = 600
onready var raycast: RayCast2D
export(float, 0.0, 10.0) var FRICTION = 10
var player = preload("res://Script/player/Player.gd")
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if abs(velocity.x) < 15:
		velocity.x = lerp(velocity.x, 0, FRICTION * delta) 
	if is_in_group("Player"):
		velocity.x = lerp(velocity.x, 200, 7 * delta)

