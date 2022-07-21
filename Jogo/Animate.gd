extends AnimatedSprite
var framesRunGlobal
var framesIdleGlobal

func verify_direction(direction: int):
	var fliper:bool
	if (direction) > 0:
		fliper = !fliper
	elif direction < 0:
		fliper = fliper
	if abs(direction) != 0:
		flip_h = action(fliper)

func verify_animated(isPlaying: Array, framesRun:int, framesIdle:int) -> void:
	var framesRun2:int
	var controlador:bool
	framesRunGlobal = isPlaying[1]
	framesIdleGlobal = isPlaying[2]
	if animation == "idle":
		if  (framesRun >=  6) and framesRun <= 12:
			frame = 1
#			framesIdle = 1 
		elif (framesRun < 6) or framesRun > 12:
			frame = 0
#			framesIdle = 0a
	else:
		action(isPlaying[0])
		playing = isPlaying[0]
		if framesIdle == 0:
			controlador = controlador
		elif framesIdle == 1:
			controlador = !controlador

		if animation == "run":
			framesRun2 = framesRun
#		if framesIdle <= 6:
#			action(controlador)
			if (controlador == true) and(framesRunGlobal <= 6):
				framesCondicion(controlador)
			print ("global: ", framesIdleGlobal)
			print("framesnot: ", framesIdle)
			print("------------")
func action(retorna:bool):
	if retorna:
		return false
	if !retorna:
		return true 
func framesCondicion(controlador):
	var condiction

	if framesIdleGlobal == 0 and playing == false:
		condiction = true
	else:
		condiction = false
	if condiction == true:
		if framesIdleGlobal == 1:
			condiction = false
			print_debug("bug")
			frame = 6
			return false
#		framesRun = 7
#	else:
#		controlador = false
#		if frame == 6 or frame <= 7:
#			pass

