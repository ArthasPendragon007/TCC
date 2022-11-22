extends AudioStreamPlayer2D

func _process(delta):
	if $".".playing == false:
		$".".play()
