extends AnimatedSprite2D

@onready var timer = $Timer

var is_moving = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Si el botón izquierdo del mouse está presionado, activar el movimiento
			if event.pressed:
				is_moving = true
				timer.start()
				play("prepare_arrow")
				await (timer.timeout)
				play("keep_aim")
			else:
				is_moving = false
				stop()
