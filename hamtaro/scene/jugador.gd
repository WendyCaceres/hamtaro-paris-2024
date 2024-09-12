extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):
	# Obtener la dirección del input del jugador
	var dir: Vector2 = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	
	if dir:
		# Cambiar la animación según la dirección en la que se mueve el personaje
		if dir.x > 0:
			$jugador.play("costado_derecho")
		elif dir.x < 0:
			$jugador.play("costado_izquierdo")
		elif dir.y > 0:
			$jugador.play("frente")
		elif dir.y < 0:
			$jugador.play("espalda")
	else:
		# Detener la animación cuando no hay movimiento
		$jugador.stop()

	# Establecer la velocidad del personaje
	velocity = dir * SPEED

	# Mover al personaje con la función `move_and_slide()`
	move_and_slide()
