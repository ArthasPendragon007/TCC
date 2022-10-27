extends Node2D


onready var saw = $saw
onready var tween = $Tween

onready var texture = $saw/textura
export var speed = 8.0
export var horizontal = true
export var distance = 192
var condic:bool
var follow = Vector2.ZERO
var velocity = Vector2()
const WAIT_DURATION = 1.0

func _ready():
	_start_tween()
	
func _start_tween():
	var move_direction = Vector2.RIGHT * distance if horizontal else Vector2.UP * distance
	var duration = move_direction.length() / float(speed * 16)
	tween.interpolate_property(
		self, "follow", Vector2.ZERO, move_direction, duration,
		Tween.TRANS_LINEAR,Tween.EASE_IN_OUT, WAIT_DURATION
	)
	tween.interpolate_property(
		self, "follow", move_direction, Vector2.ZERO, duration,
		Tween.TRANS_LINEAR,Tween.EASE_IN_OUT, duration + WAIT_DURATION * 2
	)
	tween.start()

func _physics_process(_delta: float) -> void:
	saw.position = saw.position.linear_interpolate(follow, 0.05)
	velocity = saw.position
	if velocity.x >= 189 and !condic:
		texture.flip_h = true
		condic = true
	elif velocity.x <=2 and condic:
		texture.flip_h = false
		condic = false
		



