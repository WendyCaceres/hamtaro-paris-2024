extends CharacterBody2D

const SPEED = 300.0

func _ready() -> void:
	add_to_group("jugador")

func _physics_process(delta):
	var dir: Vector2 = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	
	if dir:
		if dir.x > 0:
			$jugador.play("costado_izquierdo")
		elif dir.x < 0:
			$jugador.play("costado_derecho")
		elif dir.y > 0:
			$jugador.play("frente")
		elif dir.y < 0:
			$jugador.play("espalda")
	else:
		$jugador.stop()

	velocity = dir * SPEED
	move_and_slide()
