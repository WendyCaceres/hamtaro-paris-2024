extends Marker2D

@export var collision_shape: CollisionShape2D  # La forma de colisión del objetivo
@export var speed: float = 100.0  # Velocidad de movimiento del marker (en píxeles por segundo)
@export var objective_diameter: float = 430.0  # Diámetro total del objetivo
@onready var timer = $"../../../Timer"

@onready var static_body_2d = $"../.."
@onready var sprite_2d_3 = $"../../../Sprite2D3"
@onready var sprite_2d_2 = $"../../../Sprite2D2"
@onready var texture_rect = $"../../../TextureRect"

#Escenas
var arrow_scene = preload("res://scene/arrow.tscn")
var arrow_travel_scene = preload("res://scene/maps/archery/street.tscn")

#Valores del juego
var is_moving: bool = false  # Para verificar si el movimiento está activo
var current_target_position: Vector2

#Score
var max_turnos = 3
var current_turno = 0


func _ready():
	#Definir el objetivo inicial aleatorio
	position = get_random_point()
	
	# Definir el primer objetivo aleatorio
	current_target_position = get_random_point()
	
	

# Detectar el clic en el mouse
func _input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Si el botón izquierdo del mouse está presionado, activar el movimiento
			if event.pressed:
				is_moving = true
			else:
				if  current_turno < max_turnos:
					is_moving = false  # Detener movimiento
					static_body_2d.hide()
					sprite_2d_3.hide()
					sprite_2d_2.hide()
					texture_rect.hide()
					show_travel_scene()
					print(is_moving)
					current_turno +=1
				else:
					is_moving = false
					print("Ya no te quedan flechas para jugar :c")

func _physics_process(delta):
	# Moverse hacia la posición objetivo
	if is_moving:
		var direction = (current_target_position - position).normalized()
		position += direction * speed * delta
	
		
		# Verificar si el marker ha alcanzado el objetivo
		if position.distance_to(current_target_position) < 1.0:
			current_target_position = get_random_point()

func get_random_point() -> Vector2:
	var shape = collision_shape.shape as CircleShape2D
	var random_angle = randf_range(0, TAU)  # Genera un ángulo aleatorio (0 a 2PI)
	var random_radius = randf_range(0, shape.radius)  # Genera un radio aleatorio dentro del círculo
	
	var random_x = cos(random_angle) * random_radius
	var random_y = sin(random_angle) * random_radius
	
	return Vector2(random_x, random_y)
	
# Calcular el área de impacto en el objetivo de arquería
func calculate_impact_area():
	var center_position = collision_shape.position
	var distance_from_center = position.distance_to(center_position)

	# Dividimos el diámetro en 11 zonas
	var radius_per_zone = objective_diameter / 2 / 11

	# Determinar en qué zona cae la flecha
	var zone = int(distance_from_center / radius_per_zone)

	if zone > 10:
		zone = 10  # Limitar la zona máxima al centro (zona de puntuación máxima)
	# Mostrar la flecha en el área impactada
	show_arrow_in_zone(zone)

func show_arrow_in_zone(zone):
	# Instanciar una nueva flecha
	var arrow = arrow_scene.instantiate()

	# Posicionar la flecha donde cayó el marker
	arrow.position = position + Vector2(830,360)
	get_tree().current_scene.add_child(arrow)

	# Aquí puedes agregar lógica para manejar puntuaciones según la zona impactada
	# Calcular el puntaje según la zona
	var score = 10 - zone
	if score < 0:
		score = 0  # Asegurarse de que el puntaje mínimo sea 0
	
	# Guardar el puntaje en GameState (archery_score)
	archery_score.set_archery_points(score)
	
	# Mostrar el puntaje actual acumulado
	print("La flecha cayó en la zona:", zone)
	print("El puntaje hasta ahora es:", archery_score.get_archery_points())
	
	
func show_travel_scene():
	var arrow_travel = arrow_travel_scene.instantiate()
	get_tree().current_scene.add_child(arrow_travel)
	
	timer.start()
	await(timer.timeout)
	arrow_travel.queue_free()
	
	static_body_2d.show()
	sprite_2d_3.show()
	sprite_2d_2.show()
	texture_rect.show()
	calculate_impact_area()  # Calcular área de impacto al soltar el clic
