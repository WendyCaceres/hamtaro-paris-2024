extends Area2D

@onready var transicion = TransicionRuta  # Accede al singleton directamente

func _ready() -> void:
	print("Entrada Area2D lista")

func _on_body_entered(body: Node2D) -> void:
	print("Cuerpo entró en el área: ", body.name)  # Imprime el nombre del cuerpo
	if body.is_in_group("jugador"):  # Verifica que sea el jugador
		print("El cuerpo es un jugador")
		transicion.jugador_spam_posicion = Vector2(0, 0)  # Ajusta la posición si es necesario
		print("Cambiando escena a: res://scene/transicion.tscn")
		get_tree().change_scene_to_file("res://scene/maps/hurdles/hurdles_map.tscn")
	else:
		print("El cuerpo no es un jugador")
