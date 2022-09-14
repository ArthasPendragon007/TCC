extends KinematicBody2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween: Tween = $Tween

export var sliding_time = 0.3
var velocity:Vector2
var GRAVITY = 600
var tile_map: TileMap
var sliding = false
func _physics_process(delta):
	velocity.y += GRAVITY * delta
func initialize(_tile_map:TileMap) -> void:

	tile_map = _tile_map
	position = calculate_destion(Vector2())
func push(velocity: Vector2) -> void:
	if sliding:
		return
	var move_to = calculate_destion((velocity.normalized()))
	if can_move(move_to):
		tween.Interpolate_property(self,"gloval_position", global_position,move_to,sliding_time,Tween.TRANS_CUBIC,Tween.Erase_OUT)
		tween.start()
		sliding = true
		yield(tween,"tween_completed")
		sliding = false


func calculate_destion(direction:Vector2) -> Vector2:
	var tile_map_position = tile_map.world_to_map(global_position)
	return Vector2()
	
func can_move(move_to: Vector2) -> bool:
	return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
