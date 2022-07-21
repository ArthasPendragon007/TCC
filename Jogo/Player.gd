extends KinematicBody2D
 

onready var animate: AnimatedSprite = get_node("Animate")

onready var velocity = Vector2.ZERO
const JUMP_FORCE = -300
var number:int
var string:String
var number2:int
var condic:bool
var playing:bool
onready var matriz:Array = [playing,number, number2]
#var cartesian = cartesian2polar(velocity.x,velocity.y)
export(float, 0.0, 10.0) var ACCELERATION = 5
export(float, 0.0, 10.0) var FRICTION = 6
export(int) var GRAVITY = 600
export (int) var MAX_VELOCITY = 120


func _physics_process(delta: float) -> void:
	input_manager(delta)
	velocity.y += GRAVITY * delta
	animated()
#	bliblioteca()
	animate_manager()
	_unhandled_input(condic)
#	cartesian = cartesian2polar(velocity.x,velocity.y)
#	print("cartesian: ", cartesian)
#	print(string)
func input_manager(delta: float) -> void:
	# Função criada para todos os inputs de movimento
	move(delta)
	jump(delta)
func animate_manager() -> void:
	animate.verify_direction(velocity.x)
	if is_on_floor():
		animate.verify_animated(matriz, number, number2)

func move(delta) -> void:
	var resultante = Vector2.ZERO
	# Função criada o movumento no eixo X
	resultante.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	resultante = resultante.normalized()
	if resultante.x != 0:
		velocity.x = lerp(velocity.x, resultante.x * MAX_VELOCITY,ACCELERATION * delta )
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION * delta)
	#if Input.is_action_released():
	velocity = move_and_slide(velocity, Vector2.UP) 
func jump(delta) -> void:
	# Função criada para o pulo
	var jump = Input.is_action_pressed("ui_up")
	var jump_stop = Input.is_action_just_released("ui_up")
	if is_on_floor(): 
		if jump:
			velocity.y = JUMP_FORCE
	elif jump_stop and velocity.y < 0:
		velocity.y = lerp(velocity.y, 0, 0.3)
		#velocity.y *= 0.7
	if Input.is_action_just_pressed("S"):
		print("velocity: ",velocity)
		print("delta:", number2)
		print("FRICTION:", FRICTION)
		print("number: ", number) 
		print("string: ",string)
func animated() -> void:
	if is_on_floor(): # se estar no chão faça isso
		if abs(velocity.x) < 15: # se a velocity.x absoluta for menor que 20 entao faça isso 
			animate.play("idle") # pegue o $animate e rode a animação chamada "idle"
		if abs(velocity.x) > 15: # se a velocity.x absoluta for maior que 20 faça isso
			animate.play("run") # pegue o $animate e rode a ani,ação chamada "idle"
		if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"): # se apertar o botão "ui_right" ou "ui_left" faça isso
			matriz[0] = true  # ativa a propriedade do animate chamada 'playing'
			condic = true
		elif Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"): # se parar de apertar o botao "ui_right" ou "ui_left" faça isso
			condic = false
#			playing = false
#		else:
#			playing = !playing # desativa k propriedade do animate chamada 'playing'a

#
func bliblioteca() ->  void:

	if animate.animation == "run":
		number = animate.frame
		string = animate.animation
		animate.framesCondicion(matriz)

	if animate.animation == "idle":
		number2 = animate.frame

	
#		print("number2: ", number2)
func _unhandled_input(event) -> void:
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().change_scene("res://Interface.tscn")

#
func _on_Animate_frame_changed():
#	if animate.animation == "run":
#		if number < 6:
#			print_debug()
#			number = 6
	pass
