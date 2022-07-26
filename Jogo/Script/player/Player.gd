extends KinematicBody2D
 
var crawl = Input.is_action_pressed("ui_down")
var crawl_stop = Input.is_action_just_released("ui_down")

onready var animate: AnimatedSprite = get_node("Animate")

onready var pushR  = get_node("pushRight")
onready var pushL  = get_node("pushLeft")

onready var Checking  =get_node("Checker/Checker")
onready var Checking2 =get_node("Checker/Checker2")
onready var Checking3 =get_node("Checker/Checker3")

onready var camera:Camera2D = get_node("Camera2D")
onready var velocity = Vector2.ZERO

onready var standing_collision = $StandingShape
onready var crouching_collision = $CrouchingShape
onready var standing_hitbox = $Hitbox/StandingShape
onready var crouching_hitbox = $Hitbox/CrouchingShape



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
var move:int
var x:bool

#sistema de vidas
#--------------------------------------

var max_health = 3
var hurted = false

var knockback_dir = 1
var knockback_int = 300

signal change_life(player_health)

func _ready() -> void:
	Global.set("player", self)
	connect ("change_life", get_parent().get_node("HUD/HBoxContainer/Holder"), "on_change_life")
	emit_signal("change_life", max_health)
#--------------------------------------

func _physics_process(delta: float) -> void:
	add_to_group("player")
	input_manager(delta)
	velocity.y += GRAVITY * delta

	animate_manager()
	_unhandled_input(condic)
	push(delta)
func push(delta) -> void:
	
	if pushR.is_colliding() or pushL.is_colliding():
		animate.play("push")
		matriz[0] = true
	if pushR.is_colliding():
		var object = pushR.get_collider()
		object.move_and_slide(Vector2(17,0) * 300 * delta)
	elif pushL.is_colliding():
		var object = pushL.get_collider()
		object.move_and_slide(Vector2(-17,0) * 300 * delta)
		
	if move:
		if abs (velocity.x) > 16:
			pushL.enabled = true
			pushR.enabled = true
	else:
			pushL.enabled = false
			pushR.enabled = false
func input_manager(delta: float) -> void:
	# Função criada para todos os inputs de movimento
	move(delta)
	jump(delta)
func animate_manager() -> void:
	animate.verify_direction(velocity.x)
	if is_on_floor():
		animate.verify_animated(matriz, number, number2)
	animated()

func move(delta) -> void:
	var resultante = Vector2.ZERO
	var resultante_um = Vector2.ZERO
	# Função criada o movumento no eixo X
	resultante.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	resultante = resultante.normalized()
	#botões "ASDW"
	resultante_um.x = Input.get_action_strength("D") - Input.get_action_strength("A")
	resultante_um = resultante_um.normalized()
	move = resultante.x*resultante.x + resultante_um.x*resultante_um.x
	if resultante.x != 0:
		velocity.x = lerp(velocity.x, resultante.x * MAX_VELOCITY,ACCELERATION * delta )
		knockback_dir = resultante.x
	elif resultante_um.x != 0:
		velocity.x = lerp(velocity.x, resultante_um.x * MAX_VELOCITY,ACCELERATION * delta )
		knockback_dir = resultante_um.x

	else:
		velocity.x = lerp(velocity.x, 0, FRICTION * delta)
	#if Input.is_action_released():
	velocity = move_and_slide(velocity, Vector2.UP) 
func jump(delta) -> void:
	# Função criada para o pulo
	var jump = Input.is_action_pressed("ui_up")
	var jumpW = Input.is_action_pressed("W")
	var jump_stop = Input.is_action_just_released("ui_up")
	var jumpW_stop = Input.is_action_just_released("W")
	
	
	if is_on_floor(): 
		if jump or jumpW:
			velocity.y = JUMP_FORCE
	elif (jump_stop or jumpW) and velocity.y < 0:
		velocity.y = lerp(velocity.y, 0, 0.3)
func animated() -> void:
	
	if is_on_floor() and (!pushL.is_colliding() and !pushR.is_colliding()): # se estar no chão faça isso
		
		if abs(velocity.x) < 15: # se a velocity.x absoluta for menor que 20 entao faça isso 
			animate.play("idle") # pegue o $animate e rode a animação chamada "idle"
		elif abs(velocity.x) > 15: # se a velocity.x absoluta for maior que 20 faça isso
			animate.play("run") # pegue o $animate e rode a ani,ação chamada "idle"
		if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"): # se apertar o botão "ui_right" ou "ui_left" faça isso
			matriz[0] = true  # ativa a propriedade do animate chamada 'playing'
		if Input.is_action_pressed("A") or Input.is_action_pressed("D"):
			matriz[0] = true
	if !is_on_floor() and abs(velocity.y) > 10:
		animate.play("jump")
		if animate.frame == 2:
			animate.playing = false
func _unhandled_input(event) -> void:
	var pause_mode = Node.PAUSE_MODE_PROCESS
	var FakeInterface = load("res://Levels/scene/Player/Pause/ESC_player.tscn").instance()
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().paused = !get_tree().paused
			get_tree().current_scene.add_child(FakeInterface)
			animate.playing = false
			camera.current = true
			camera.zoom.x = 0.5
			camera.zoom.y = 0.5

func _toggled(button_pressed):
	get_tree().paused = button_pressed
	# Pause or unpause the SceneTree based on whether the button is
	# toggled on or off.
#Funções para os dialogos
func _on_Dialogo_AD_body_entered(body: Node):
	if body.name == "Player":
		var dialogo_AD = Dialogic.start("ControleAD")
		add_child(dialogo_AD)

func _on_Dialogo_JUMP_body_entered(body: Node):
	if body.name == "Player":
		var dialogo_JUMP = Dialogic.start("ControleJUMP")
		add_child(dialogo_JUMP)

func _on_Dialogo_Empurrar_body_entered(body: Node):
	if body.name == "Player":
		var dialogo_Empurrar = Dialogic.start("MecânicaEmpurrar")
		add_child(dialogo_Empurrar)


func _on_Segundo_Aviso_Boss_body_entered(body):
	if body.name == "Player":
		var Segundo_Aviso_Boss = Dialogic.start("Segundo_aviso_boss")
		add_child(Segundo_Aviso_Boss)

func _on_Dialogo_AD_body_exited(body: Node):
	var dialogo_AD = Dialogic.start("ControleAD")
	if body.name == "Player":
		get_parent().get_node("Dialogo_AD/Caixa_AD").queue_free()


func _on_Dialogo_JUMP_body_exited(body: Node):
	var dialogo_JUMP = Dialogic.start("ControleJUMP")
	if body.name == "Player":
		get_parent().get_node("Dialogo_JUMP/Caixa_JUMP").queue_free()

func _on_Dialogo_Empurrar_body_exited(body: Node):
	var dialogo_Empurrar = Dialogic.start("MecânicaEmpurrar")
	if body.name == "Player":
		get_parent().get_node("Dialogo_Empurrar/Caixa_Empurrar").queue_free()


func _on__body_entered(body: Node):
	if body.name == "Player":
		var pipi = Dialogic.start("Aviso_boss")
		add_child(pipi)


func _on_aviso_body_exited(body):
	var pipi = Dialogic.start("Aviso_boss")
	if body.name == "Player":
		get_parent().get_node("aviso/col").queue_free()
func _on_Dialogo_Lobeira_body_entered(body):
	pass # Replace with function body.
	if body.name == "Player":
		var lobeira = Dialogic.start("Aviso_lobeira")
		add_child((lobeira))

func _on_Dialogo_Lobeira_body_exited(body):
	if body.name == "Player":
		get_parent().get_node("Dialogo_Lobeira/col").queue_free()


func _on_Segundo_Aviso_Boss_body_exited(body):
	if body.name == "Player":
		get_parent().get_node("Segundo_Aviso_Boss/Segundo_Aviso_Col").queue_free()
#----------------------------------------------------------------------------


#FUNÇÕES PARA SISTEMA DE VIDAS
func _on_Hitbox_body_entered(body: Node) -> void:
	print ("Player colidiu")

func knockback():
	velocity.x = -knockback_dir * knockback_int
	velocity = move_and_slide(velocity)

func _on_Hurtbox_body_entered(body: Node) -> void:
	print ("Inimigo colidiu")
	Global.player_health -= 1
	hurted = true
	emit_signal("change_life", Global.player_health)
	knockback()
	get_node("Hurtbox/Collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(1), "timeout")
	get_node("Hurtbox/Collision").set_deferred("disabled", false)
	hurted = false
	gameover()

func gameover() -> void:
	var FakeInterface = load("res://Levels/scene/GAME OVER/game_over.tscn").instance()
	if Global.player_health < 1:
		Global.is_dead = true
		get_tree().paused = !get_tree().paused
		get_tree().current_scene.add_child(FakeInterface)


func _on_Trapbox_body_entered(body):
	print ("Trap colidiu")
	Global.player_health -= 1
	hurted = true
	emit_signal("change_life", Global.player_health)
	knockback()
	get_node("Trapbox/ColTrap").set_deferred("disabled", true)
	yield(get_tree().create_timer(1), "timeout")
	get_node("Trapbox/ColTrap").set_deferred("disabled", false)
	hurted = false
	gameover()
#----------------------------------------------------------------------------


func _on_Trigger_PlayerEntered():
	camera.current = false


func _on_BOSS_Parda_BossDead():
	camera.current = true









